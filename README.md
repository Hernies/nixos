# Dotfiles

NixOS configuration for my machines.

Current active host:

- `kyuden` — main desktop

Planned hosts:

- `hiruma` — laptop, currently pending migration
- `rokugan` — future VPS/server

## Layout

```text
.
├── flake.nix
├── flake.lock
├── hosts/
│   ├── kyuden/
│   │   ├── configuration.nix
│   │   └── hardware-configuration.nix
│   ├── hiruma/
│   │   └── README.md
│   └── rokugan/
│       └── README.md
├── modules/
└── archive/



