# ClamAV Scan to Flock Notification
```shell title="clamav_scan" showLineNumbers
#!/bin/bash

# === Configuration ===
FLOCK_TOKEN="TOKEN"
FLOCK_URL="https://api.flock.com/hooks/sendMessage/${FLOCK_TOKEN}"

CLAMAV_DB_URLS=(
  "https://signature-rule-distribution.com/example/clamav_custom.hdb"
  "https://signature-rule-distribution.com/example/clamav_custom.yar"
  "https://signature-rule-distribution.com/example/clamav_custom.ndb"
)

DB_PATH="/var/lib/clamav"
LOG_PATH="/var/log/clamav"
LOG_NAME="$(date -Im)_clamscan.log"

mkdir -p "${DB_PATH}" "${LOG_PATH}"

# === Pre-checks ===
if [[ "${FLOCK_TOKEN}" == "change-me" || -z "${FLOCK_TOKEN}" ]]; then
    echo "FLOCK_TOKEN is not set, exiting."
    exit 1
fi

# === comment this if Docker used ===
# if ! command -v clamscan > /dev/null; then
#     echo "'clamscan' is required but not installed."
#     exit 1
# fi

# === Clean previous logs ===
rm -f "${LOG_PATH}"/*.log

# === Download ClamAV DB files ===
cd "${DB_PATH}" || exit 1
for url in "${CLAMAV_DB_URLS[@]}"; do
    echo "Downloading ${url}"
    curl --max-time 120 -L "${url}" -O || exit 1
done

# === Run ClamAV Scan ===
# echo "Running clamscan... this may take a while"
# clamscan --infected  --cross-fs=yes --database=${DB_PATH} \
# 		 --recursive=yes --allmatch=no  --log=${LOG_PATH}/${log_name} \
# 		 --exclude-dir="/var/lib/clamav/|/data*/|/var/lib/mysql/"  /

# === Run Dockerized ClamAV Scan ===
echo "Running Dockerized clamscan..."

docker run --rm \
  -v "/:/scan:ro" \
  -v "${DB_PATH}:/var/lib/clamav" \
  -v "${LOG_PATH}:/logs" \
  clamav/clamav:stable \
  clamscan --infected --cross-fs=yes --recursive=yes --allmatch=no \
           --log=/logs/${LOG_NAME} --exclude-dir="^/var/lib/clamav/|^/data.*/|^/var/lib/mysql/|^/scan/usr/lib/clamav-signatures/" /scan

CLAMSCAN_EXIT_CODE=$?

# === Handle Results ===
if [[ ${CLAMSCAN_EXIT_CODE} -eq 0 ]]; then
    echo "All clean, no viruses found. Exiting."
    exit 0
fi

# Extract summary
SUMMARY=$(sed -n '/SCAN SUMMARY/,$p' "${LOG_PATH}/${LOG_NAME}" | sed -z 's/\n/<br>/g')
HOST=$(hostname)

if grep -q 'Infected files: 0' "${LOG_PATH}/${LOG_NAME}"; then
    echo "No infected files, exiting."
    exit 0
fi

# === Send Notification to Flock ===
echo "Infected files found! Sending to Flock..."

curl -X POST "${FLOCK_URL}" \
     -H "Content-Type: application/json" \
     -d "{\"flockml\": \"<flockml>ClamAV scan results for: <b>${HOST}</b><br>Date: $(date -Im)<br>Results:<br>${SUMMARY}</flockml>\"}"
```