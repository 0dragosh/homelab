resource "proxmox_vm_qemu" "talos-control-plane-node-0" {
    name        = "${var.cluster_name}-controlplane-0"
    # iso         = var.iso_image_location
    full_clone  = false
    target_node = "nuc1"
    agent       = var.qemu_guest_agent
    vmid        = "200"
    qemu_os     = "l26" # Linux kernel type
    memory      = "8192"
    cores       = 4
    sockets     = 1
    numa        = true
    hotplug     = "network,disk,usb"
    network {
        model  = "virtio"
        bridge = var.network_bridge
        tag    = var.homelab_vlan
        macaddr = "1a:10:50:00:00:00"
    }
    network {
        model  = "virtio"
        bridge = var.network_bridge
        tag    = var.pve_vlan
        macaddr = "1a:20:50:00:00:00"
    }
    disk {
        type    = "virtio"
        size    = var.boot_disk_size
        storage = var.boot_disk_storage_pool
    }
}

resource "proxmox_vm_qemu" "talos-control-plane-node-1" {
    name        = "${var.cluster_name}-controlplane-1"
    iso         = var.iso_image_location
    full_clone  = false
    target_node = "pve-lilslim"
    agent       = var.qemu_guest_agent
    vmid        = "201"
    qemu_os     = "l26" # Linux kernel type
    memory      = "8192"
    cores       = 4
    sockets     = 1
    numa        = true
    hotplug     = "network,disk,usb"
    network {
        model  = "virtio"
        bridge = var.network_bridge
        tag    = var.homelab_vlan
        macaddr = "1a:10:50:00:00:01"
    }
    network {
        model  = "virtio"
        bridge = var.network_bridge
        tag    = var.pve_vlan
        macaddr = "1a:20:50:00:00:01"
    }
    disk {
        type    = "virtio"
        size    = var.boot_disk_size
        storage = var.boot_disk_storage_pool
    }
}

resource "proxmox_vm_qemu" "talos-control-plane-node-2" {
    name        = "${var.cluster_name}-controlplane-2"
    iso         = var.iso_image_location
    full_clone  = false
    target_node = "pve-fatman"
    agent       = var.qemu_guest_agent
    vmid        = "202"
    qemu_os     = "l26" # Linux kernel type
    memory      = "8192"
    cores       = 4
    sockets     = 1
    numa        = true
    hotplug     = "network,disk,usb"
    network {
        model  = "virtio"
        bridge = var.network_bridge
        tag    = var.homelab_vlan
        macaddr = "1a:10:50:00:00:02"
    }
    network {
        model  = "virtio"
        bridge = var.network_bridge
        tag    = var.pve_vlan
        macaddr = "1a:20:50:00:00:02"
    }
    disk {
        type    = "virtio"
        size    = var.boot_disk_size
        storage = var.boot_disk_storage_pool
    }
}
