resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = var.resource_group_name
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                                = "aks-cluster001"
  dns_prefix                          = "aks-cluster001-dns"
  kubernetes_version                  = "1.34.6"
  local_account_disabled              = false
  resource_group_name                 = var.resource_group_name
  location                            = var.resource_group_location
  node_os_upgrade_channel             = "NodeImage"
  node_resource_group                 = "MC_Rg-aks_aks-cluster001_centralindia"
  role_based_access_control_enabled   = true
  sku_tier                            = "Free"

  default_node_pool {
    name                          = "agentpool"
    auto_scaling_enabled          = true
    max_count                     = 5
    max_pods                      = 110
    min_count                     = 2
    node_count                    = 2
    orchestrator_version          = "1.34.6"
    os_disk_size_gb               = 128
    os_disk_type                  = "Managed"
    os_sku                        = "Ubuntu"
    type                          = "VirtualMachineScaleSets"
    vm_size                       = "Standard_D2s_v3"
  }
  identity {
    identity_ids = []
    type         = "SystemAssigned"
  }
  network_profile {
    dns_service_ip      = "10.0.0.10"
    ip_versions         = ["IPv4"]
    load_balancer_sku   = "standard"
    network_data_plane  = "azure"
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    outbound_type       = "loadBalancer"
    pod_cidr            = "10.244.0.0/16"
    pod_cidrs           = ["10.244.0.0/16"]
    service_cidr        = "10.0.0.0/16"
    service_cidrs       = ["10.0.0.0/16"]
  }
  node_provisioning_profile {
    default_node_pools = "Auto"
    mode               = "Manual"
  }
  windows_profile {
    admin_password = "Password123!@#"
    admin_username = "azureuser"
  }
}

resource "azurerm_container_registry" "acr" {
  name                          = "acrforaks001"
  admin_enabled                 = true
  location                      = var.resource_group_location
  public_network_access_enabled = true
  resource_group_name           = var.resource_group_name
  sku                           = "Standard"
  trust_policy_enabled          = false
  zone_redundancy_enabled       = false
}