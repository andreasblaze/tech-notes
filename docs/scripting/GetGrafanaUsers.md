# GET Grafana Users
```python title="GetGrafanaUsers" showLineNumbers
import requests

# Configuration
grafana_url = "https://grafana.com"
api_token = "<GRAFANA-API-TOKEN>"

# Construct the headers with the API key
headers = {
    "Authorization": f"Bearer {api_token}",
    "Content-Type": "application/json"
}

# API endpoint
endpoint = f"{grafana_url}/api/org/users"

def get_grafana_users():
    try:
        response = requests.get(endpoint, headers=headers)
        response.raise_for_status()  # Raise an error for bad HTTP status codes
        users = response.json()
        
        print("Grafana Users:")
        for user in users:
            print(f"- ID: {user['userId']}, Name: {user['name']}, Email: {user['email']}, Role: {user['role']}")
    except requests.exceptions.RequestException as e:
        print(f"Error fetching users: {e}")

if __name__ == "__main__":
    get_grafana_users()
```