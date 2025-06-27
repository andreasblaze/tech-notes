# PagerDuty - Flock Web Backend Customs | Flask
```python title="PdFlockHandler" showLineNumbers
from flask import Flask, request
import requests
import os
from threading import Thread
from dotenv import load_dotenv

load_dotenv()

# === Config ===
PD_TOKEN = "<TOKEN>"
PD_FROM = "andrii.bondariev@example.com"
FLOCK_HOOK_URL = "https://api.flock.com/hooks/sendMessage/<TOKEN>"
INCIDENT_ID = "ID"
BASE_URL = "http://localhost:5000"  # Used to build links

# === Shared headers ===
PD_HEADERS = {
    "Authorization": f"Token token={PD_TOKEN}",
    "Accept": "application/vnd.pagerduty+json;version=2",
    "Content-Type": "application/json",
    "From": PD_FROM
}

# === Flask Web Server ===
app = Flask(__name__)

@app.route("/acknowledge")
def acknowledge():
    incident_id = request.args.get("id")
    resp = requests.put(
        f"https://api.pagerduty.com/incidents/{incident_id}",
        headers=PD_HEADERS,
        json={"incident": {"type": "incident_reference", "status": "acknowledged"}}
    )
    return f"Acknowledged {incident_id}" if resp.ok else f"Failed: {resp.text}", resp.status_code

@app.route("/snooze")
def snooze():
    incident_id = request.args.get("id")
    resp = requests.post(
        f"https://api.pagerduty.com/incidents/{incident_id}/snooze",
        headers=PD_HEADERS,
        json={"duration": 14400}
    )
    return f"Snoozed {incident_id}" if resp.status_code == 202 else f"Failed: {resp.text}", resp.status_code

# === Flock Message Sender ===
def send_flock_message():
    ack_url = f"{BASE_URL}/acknowledge?id={INCIDENT_ID}"
    snooze_url = f"{BASE_URL}/snooze?id={INCIDENT_ID}"

    payload = {
        "text": "PD Test Alert",
        "attachments": [
            {
                "color": "#FFA500",
                "views": {
                    "flockml": f"""
<flockml>
<b>Incident:</b> {INCIDENT_ID}<br>
<a href="{ack_url}">Acknowledge</a> | 
<a href="{snooze_url}">Snooze 4h</a>
</flockml>
"""
                }
            }
        ]
    }

    resp = requests.post(FLOCK_HOOK_URL, json=payload)
    print("Sent to Flock" if resp.ok else f"Flock error: {resp.status_code} {resp.text}")


# === Boot ===
if __name__ == "__main__":
    # Run Flask in a background thread
    Thread(target=lambda: app.run(port=5000)).start()

    # Wait briefly for Flask to come online
    import time
    time.sleep(1)

    # Send message to Flock
    send_flock_message()

    import time

    print("Server is running at http://localhost:5000")
    print("You can now click links in Flock to test.")

    try:
        while True:
            time.sleep(60)
    except KeyboardInterrupt:
        print("Shutting down.")