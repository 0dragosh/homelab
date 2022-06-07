module "homelab-talos-0" {
  source = "github.com/ilpozzd/terraform-talos-vsphere-cluster?ref=v1.1.3"

  cluster_name = "homelab-talos-0"
  datacenter = "Datacenter"
  datastores = [
    "large1",
    "large1-slim",
    # "medium1-slim"
  ]
  hosts = [
    "fatman.home.lan",
    "lilslim.home.lan",
  ]
  resource_pool  = "talos"
  folder         = "talos"
  remote_ovf_url = "https://github.com/siderolabs/talos/releases/download/v1.0.5/vmware-amd64.ova"

  cluster_control_plane = {
    endpoint = "https://10.250.14.220:6443"
    localAPIServerPort = "6443"
  }
  control_plane_cluster_configuration = {
  network = {
      cni = {
          name = "custom"
          urls = ["https://raw.githubusercontent.com/0dragosh/homelab/main/k8s/clusters/homelab-talos-0/integrations/cilium-quick-install/quick-install.yaml"]
      }
      dnsDomain = "cluster.local"
      podSubnets = ["10.244.0.0/16"]
      serviceSubnets = ["10.96.0.0/16"]
  }
  proxy = {
      disabled = true
  }
  scheduler = {
    image = "k8s.gcr.io/kube-scheduler:v1.23.6"
    extraArgs = {
        feature-gates = "MixedProtocolLBService=true,EphemeralContainers=True"
      }
  }
  apiServer = {
    image = "k8s.gcr.io/kube-apiserver:v1.23.6"
    extraArgs = {
        feature-gates = "MixedProtocolLBService=true,EphemeralContainers=True"
    }
    certSANs = [
      "10.250.14.220",
    ]
  }
  controllerManager = {
    image = "k8s.gcr.io/kube-controller-manager:v1.23.6"
    extraArgs = {
        feature-gates = "MixedProtocolLBService=true,EphemeralContainers=True"
      }
  }
}

  control_plane_count    = 3
  control_plane_num_cpus = 4
  control_plane_memory   = 2048
  control_plane_disks = [
    {
      label = "sda"
      size  = 20
    }
  ]
  control_plane_network_interfaces = [
    {
      name = "vlan_1000_homelab_10_250_0_0_20"
    }
  ]

  worker_count    = 3
  worker_num_cpus = 8
  worker_memory   = 16384
  worker_disks = [
    {
      label = "sda"
      size  = 40
    },
    {
      label = "sdb"
      size  = 500
      thin_provisioned = true
    }
  ]
  worker_network_interfaces = [
    {
      name = "vlan_1000_homelab_10_250_0_0_20"
    }
  ]

  machine_base_configuration = {
    install = {
      disk       = "/dev/sda"
      image      = "ghcr.io/siderolabs/installer:latest"
      bootloader = true
      wipe       = false
    }
    time = {
      disabled = false
      servers = [
        "10.250.0.1"
      ]
      bootTimeout = "2m0s"
    }
    features = {
      rbac = true
    }
    kubelet = {
      image = "ghcr.io/siderolabs/kubelet:v1.23.6"
      extraArgs = {
        feature-gates = "MixedProtocolLBService=true,EphemeralContainers=True"
      }
    }
  }

  machine_network = {
    nameservers = [
      "10.250.0.1",
    ]
  }

  control_plane_machine_cert_sans = [[
    "10.250.14.220",
  ]]

  control_plane_machine_network_interfaces = [
    [
      {
        interface = "eth0"
        addresses = [
          "10.250.13.1/20"
        ]
        routes = [
          {
            network = "0.0.0.0/0"
            gateway = "10.250.0.1"
          }
        ]
        vip = {
          ip = "10.250.14.220"
        }
      }
    ],
    [
      {
        interface = "eth0"
        addresses = [
          "10.250.13.2/20"
        ]
        routes = [
          {
            network = "0.0.0.0/0"
            gateway = "10.250.0.1"
          }
        ]
        vip = {
          ip = "10.250.14.220"
        }
      }
    ],
    [
      {
        interface = "eth0"
        addresses = [
          "10.250.13.3/20"
        ]
        routes = [
          {
            network = "0.0.0.0/0"
            gateway = "10.250.0.1"
          }
        ]
        vip = {
          ip = "10.250.14.220"
        }
      }
    ]
  ]

  worker_machine_cert_sans = [[
    "10.250.13.4",
    "10.250.13.5",
    "10.250.13.6",
    "10.250.14.220",
  ]]

  worker_machine_network_interfaces = [
    [
      {
        interface = "eth0"
        addresses = [
          "10.250.13.4/20"
        ]
        mtu = "9000"
        routes = [
          {
            network = "0.0.0.0/0"
            gateway = "10.250.0.1"
          }
        ]
      }
    ],
    [
      {
        interface = "eth0"
        addresses = [
          "10.250.13.5/20"
        ]
        mtu = "9000"
        routes = [
          {
            network = "0.0.0.0/0"
            gateway = "10.250.0.1"
          }
        ]
      }
    ],
    [
      {
        interface = "eth0"
        addresses = [
          "10.250.13.6/20"
        ]
        mtu = "9000"
        routes = [
          {
            network = "0.0.0.0/0"
            gateway = "10.250.0.1"
          }
        ]
      }
    ]
  ]

  kubeconfig_path = "./configs/kubeconfig"
  talosconfig_path = "./configs/talosconfig"
}
