# ansible-playbooks

My Ansible playbooks for automated machine configuration after OS installation.

## Overview

This repository contains Ansible playbooks and roles for quickly setting up a new machine. The playbooks handle installing common utilities, development tools, and macOS-specific software.

## Structure

```
.
├── ansible.cfg          # Ansible configuration
├── site.yml             # Main playbook entry point
├── inventory/
│   ├── hosts            # Inventory file (add your machines here)
│   └── group_vars/
│       └── all.yml      # Variables that apply to all hosts
└── roles/
    ├── common/          # Common packages for Linux machines
    ├── development/     # Development tools for Linux machines
    └── macos/           # macOS-specific packages via Homebrew
```

## Prerequisites

- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html) installed on the machine you want to configure
- `sudo` privileges on that machine

For macOS targets, the `community.general` Ansible collection is also required:

```bash
ansible-galaxy collection install community.general
```

## Quick Start — Configure This Machine

The simplest use case is running the playbook directly on the machine you just set up (no IP address, no SSH, no network configuration needed):

1. Install Ansible:

   ```bash
   # Ubuntu/Debian
   sudo apt update && sudo apt install -y ansible
   ```

2. Clone this repository on the machine you want to configure:

   ```bash
   git clone https://github.com/tylermilner/ansible-playbooks.git
   cd ansible-playbooks
   ```

3. Run the playbook against the local machine (the `-K` flag prompts for your `sudo` password):

   ```bash
   ansible-playbook site.yml --limit local -K
   ```

That's it — no IP addresses or SSH setup required.

## Setup — Configure Remote Machines

If you want to manage *other* machines on your network over SSH, edit `inventory/hosts` and add them under the `[linux]` or `[macos]` group, then run:

```bash
ansible-playbook site.yml -K
```

## Usage

Configure the local machine (most common use case — see [Quick Start](#quick-start--configure-this-machine) above):

```bash
ansible-playbook site.yml --limit local -K
```

Configure all remote hosts defined in `inventory/hosts`:

```bash
ansible-playbook site.yml -K
```

Target a specific group of remote machines:

```bash
ansible-playbook site.yml --limit linux -K
ansible-playbook site.yml --limit macos
```

Perform a dry-run (check mode) without making any changes:

```bash
ansible-playbook site.yml --check --limit local -K
```

*(Optional)* Customize the packages to install by editing the role defaults in `roles/*/defaults/main.yml`.

## Roles

### `common`

Installs a base set of packages on Linux machines (Debian/Ubuntu and RedHat/Fedora families supported). Configurable via `roles/common/defaults/main.yml`.

| Variable          | Default                                        | Description              |
|-------------------|------------------------------------------------|--------------------------|
| `common_packages` | `[curl, git, htop, tree, unzip, vim, wget]`   | Packages to install      |

### `development`

Installs development tools on Linux machines. Optionally installs Docker. Configurable via `roles/development/defaults/main.yml`.

| Variable          | Default               | Description                          |
|-------------------|-----------------------|--------------------------------------|
| `dev_packages`    | `[build-essential, python3, python3-pip, python3-venv]` | Dev packages to install |
| `install_docker`  | `false`               | Set to `true` to install Docker      |

### `macos`

Installs packages via [Homebrew](https://brew.sh/) on macOS machines. Configurable via `roles/macos/defaults/main.yml`.

| Variable             | Default                                      | Description                  |
|----------------------|----------------------------------------------|------------------------------|
| `homebrew_packages`  | `[curl, git, htop, tree, vim, wget]`         | Homebrew formulae to install |
| `homebrew_casks`     | `[]`                                         | Homebrew casks to install    |

## License

MIT
