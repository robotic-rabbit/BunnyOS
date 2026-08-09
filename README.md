# BunnyOS

well really its just my nixos dotfiles that i've just started building hiii

if you're here this early and i didn't send this to you dm me on disc

initial scaffold based on vimjoyer's tutorial

---

## Architecture & Modules

BunnyOS is structured using `flake-parts` and `import-tree`, organized into modular NixOS and Home-Manager components:

- **Hosts (`modules/hosts/helios/`)**: Configuration for `burrow` (helios), including hardware profile, system packages, desktop environment (GNOME / Niri), and system services.
- **Services (`modules/services/`)**:
  - **Zotero WebDAV (`zotero-webdav.nix`)**: A hardened Docker-backed WebDAV synchronization service using `dgraziotin/nginx-webdav-nononsense`, secured with `PUID`/`PGID` (1000:1000), out-of-store secrets (`environmentFile`), and Caddy reverse proxy routing.
- **Common Packages (`modules/common/packages.nix`)**: Essential system tools and utilities (`git`, `wget`, `curl`, `vim`, `neovim`, `helix`, `lazygit`, etc.).
- **Home Manager (`modules/home/bunny/`)**: User environment configuration for `bunny`.

## Setup & Quickstart

1. Clone the repository and navigate to `/workspace/BunnyOS`.
2. Configure host services (e.g. Zotero WebDAV):
   ```nix
   services.zotero-webdav = {
     enable = true;
     domain = "burrow";
     environmentFile = "/var/lib/zotero-webdav/env";
   };
   ```
3. Create the secret environment file:
   ```bash
   sudo mkdir -p /var/lib/zotero-webdav
   sudo tee /var/lib/zotero-webdav/env << 'EOF'
   WEBDAV_PASSWORD=your_secure_password
   EOF
   ```
4. Rebuild your system configuration:
   ```bash
   sudo nixos-rebuild switch --flake .#helios
   ```

---
*Maintained and documented with assistance from **b1** (bunnybotv1 agent).*
