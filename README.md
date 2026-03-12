# ansible-playbooks
My Ansible playbooks for automated OS configuration.

## Development

### Setup

Create and activate a virtual environment, then install the dependencies:

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

### Linting

Run the lint script to check all playbooks:

```bash
./lint.sh
```

### Testing

Automated VM configuration testing is done using [Molecule](https://ansible.readthedocs.io/projects/molecule/) with [Vagrant](https://www.vagrantup.com/) and [VirtualBox](https://www.virtualbox.org/).

#### Prerequisites

Install the following tools before running tests:

- [Vagrant](https://developer.hashicorp.com/vagrant/install)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

#### Running Tests

Run the full Molecule test suite (create VM, converge, verify, destroy):

```bash
molecule test
```

Or run individual steps:

```bash
# Create the VM
molecule create

# Run the playbook against the VM
molecule converge

# Verify the machine state
molecule verify

# Destroy the VM
molecule destroy
```

The `molecule/default/` scenario:
- **Converge** (`converge.yml`): Runs the playbook tasks against an Ubuntu 22.04 VM.
- **Verify** (`verify.yml`): Checks that `curl` is installed and the `uv` binary is present at the expected path.
