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

- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html) installed on the control machine
- SSH access to the target machine(s), or run locally against `localhost`
- `sudo` privileges on the target machine(s)

For macOS targets, the `community.general` Ansible collection is also required:

```bash
ansible-galaxy collection install community.general
```

## Setup

1. Clone this repository:

   ```bash
   git clone https://github.com/tylermilner/ansible-playbooks.git
   cd ansible-playbooks
   ```

2. Edit `inventory/hosts` and add your machines under the appropriate group (`linux` or `macos`).

3. *(Optional)* Customize the role defaults in `roles/*/defaults/main.yml` to tailor the installed packages.

## Usage

Run the main playbook against all configured hosts:

```bash
ansible-playbook site.yml
```

Prompt for the `sudo` password (if needed):

```bash
ansible-playbook site.yml -K
```

Target only Linux machines:

```bash
ansible-playbook site.yml --limit linux
```

Target only macOS machines:

```bash
ansible-playbook site.yml --limit macos
```

Run against the local machine:

```bash
ansible-playbook site.yml --limit local
```

Perform a dry-run (check mode):

```bash
ansible-playbook site.yml --check
```

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
