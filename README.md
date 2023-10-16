# NixOS of zhews

## Project Structure

- `config`, configuration that is not in the nix format.
- `home`, configuration for the home of zhews.
- `system`, configuration of the system.

## Workflows

These workflows require this repository to be cloned within the system.

The following commands are executed within this repository.

### Apply System

```shell
sudo nixos-rebuild switch --flake .
```

### Apply Home

```shell
home-manager build --flake .
home-manager switch --flake .
```

## Device Preparation

### WIFI

```shell
sudo systemctl start wpa_supplicant
sudo wpa_cli
```

```shell
add_network
set_network 0 ssid "<SSID>"
set_network 0 psk "<PASSWORD>"
set_network 0 key_mgmt WPA-PSK
enable_network 0
quit
```

### Partitioning

```shell
sudo parted /dev/<DISK> -- mklabel gpt
sudo parted /dev/<DISK> -- mkpart ESP fat32 0% 512MB
sudo parted /dev/<DISK> -- set 1 esp on
sudo parted /dev/<DISK> -- mkpart primary 512MB 100%
```

### LUKS

```shell
sudo cryptsetup luksFormat /dev/<DISK>p2
sudo cryptsetup luksOpen /dev/<DISK>p2 cryptlvm
sudo cryptsetup config /dev/<DISK>p2 --label cryptlvm
```

### LVM

```shell
sudo pvcreate /dev/mapper/cryptlvm
sudo vgcreate vgNixOS /dev/mapper/cryptlvm
sudo lvcreate -L <RAM * 1.5>G vgNixOS -n swap
sudo lvcreate -l 100%FREE vgNixOS -n root
```

### Formatting

```shell
sudo mkfs.fat -F 32 -n boot /dev/<DISK>p1
sudo mkswap -L swap /dev/vgNixOS/swap
sudo mkfs.ext4 -L root /dev/vgNixOS/root
```

### Mounting

```shell
sudo mount /dev/vgNixOS/root /mnt
sudo mount --mkdir /dev/<DISK>p1 /mnt/boot
sudo swapon /dev/vgNixOS/swap
```
