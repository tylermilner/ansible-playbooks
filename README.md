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

* **[Molecule](https://ansible.readthedocs.io/projects/molecule/)** - Ansible-native testing framework that drives the full test lifecycle (create, converge, verify, destroy).
* **[Vagrant](https://www.vagrantup.com/)** - Tool for building and managing virtual machine environments, used locally to spin up an isolated Ubuntu VM for testing.
* **[VirtualBox](https://www.virtualbox.org/)** - Virtualization platform used by Vagrant to run the Ubuntu VM.

#### Prerequisites

Install the following tools before running tests locally:

- [Vagrant](https://developer.hashicorp.com/vagrant/install)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

#### Running Tests

**Locally** (uses Vagrant + VirtualBox to create an isolated Ubuntu 24.04 VM):

```bash
molecule test
```

**In CI** (runs directly on the ephemeral Ubuntu 24.04 GitHub Actions runner):

```bash
molecule test -s ci
```

Or run individual steps (locally):

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

The two Molecule scenarios share a single `molecule/verify.yml` that asserts the final machine state (curl installed, uv binary present):
- **`molecule/default/`** — Uses Vagrant + VirtualBox to spin up a `bento/ubuntu-24.04` VM. The `ubuntu` user is created in `prepare.yml`, then `converge.yml` applies the shared tasks from `tasks/main.yml` against the VM.
- **`molecule/ci/`** — Uses the local driver (no VM needed) and runs directly on the GitHub Actions runner. `converge.yml` imports `mbp-2010-ubuntu.yml` directly, keeping the CI test as representative as possible.
