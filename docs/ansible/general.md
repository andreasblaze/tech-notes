# Concepts

## Ansible Roles
Ansible Roles are a way to organize and reuse automation code in a structured, modular format.

A role groups related Ansible content — tasks, handlers, templates, files, and variables — into a single, self-contained directory. This makes playbooks cleaner, easier to maintain, and reusable across multiple projects.
```bash
roles/
  nginx/
    tasks/
      main.yml
    handlers/
      main.yml
    templates/
      nginx.conf.j2
    vars/
      main.yml
```

## Installing Ansible Roles
Fetch and install all required Ansible roles from the *requirements.yml* file before running any playbooks.
- Runs inside a Docker container specified by *ansibleDockerImage*.
- Uses a Bitbucket SSH key (retrieved securely via Vault) for authentication when fetching private roles or repositories.
- Installs roles using:
```bash
ansible-galaxy install -p playbooks/roles -r requirements.yml
```
- `ANSIBLE_LOCAL_TEMP` is set to *$[WORKSPACE]/.ansible* to define a temporary working directory for Ansible operations.
> Ensures all required roles are locally available in *playbooks/roles/* before any playbook execution.
## Prepare SSH Key for Ansible
Make a Jenkins SSH private key available for Ansible to establish SSH connections with managed nodes.
Copies the Jenkins agent's SSH private key to the workspace:
```bash
install -m 600 /home/jenkins/.ssh/id_rsa ${WORKSPACE}/jenkins_id_rsa
```
> Provides the private key (*jenkins_id_rsa*) that will later be used by Ansible for host authentication.
## Execute Ansible Playbook
Run the main Ansible playbook using the previously installed roles and configured SSH key.
- Executes within the same Ansible Docker image (*ansibleDockerImage*) for consistency.
- Runs the main playbook *playbooks/main.yml* with elevated privileges (`-b` flag).
```bash
ansible-playbook -i ${ansibleInventoryPath} \
  --private-key ../jenkins_id_rsa \
  -u jenkins \
  -b \
  playbooks/main.yml \
  -e 'WORKSPACE=${WORKSPACE}' \
  -e 'clamav_token=${env.CLAMAV_FLOCK_TOKEN}'
```
> Executes the infrastructure automation defined in main.yml.
> Passes necessary runtime variables for environment-specific configurations.