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

Automated configuration testing is done using [Molecule](https://ansible.readthedocs.io/projects/molecule/).

* **[Molecule](https://ansible.readthedocs.io/projects/molecule/)** - Ansible-native testing framework that drives the full test lifecycle (create, converge, verify, destroy).

#### Running Tests

Run the full Molecule test suite (converge, verify):

```bash
molecule test
```

Or run individual steps:

```bash
# Run the playbook against the test instance
molecule converge

# Verify the machine state
molecule verify

# Clean up
molecule destroy
```

The `molecule/default/` scenario:
- **Converge** (`converge.yml`): Runs `mbp-2010-ubuntu.yml` directly against the test instance.
- **Verify** (`verify.yml`): Checks that `curl` is installed and the `uv` binary is present at the expected path.

> **Note:** The `molecule test` command is also run automatically in CI on an Ubuntu 24.04 runner, which closely matches the target homelab environment.
