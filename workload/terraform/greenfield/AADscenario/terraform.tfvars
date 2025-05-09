/*tested on
Terraform v1.4.2
on windows_amd64
+ provider registry.terraform.io/azure/azapi v1.9.0
+ provider registry.terraform.io/hashicorp/azuread v2.25.0
+ provider registry.terraform.io/hashicorp/azurerm v3.44.1
+ provider registry.terraform.io/hashicorp/local v2.2.3
+ provider registry.terraform.io/hashicorp/random v3.3.2
+ provider registry.terraform.io/hashicorp/time v0.8.0
*/

##############  Modify the following variables to match your environment by replacing the values in quotes #####################
environment               = "dev"
avdLocation               = "uksouth"                     # change to your Azure region
prefix                    = "poc1"                        # change to your prefix 4 characters (letters and numbers only)
local_admin_username      = "localadmin"                  # Your AVD VM local Windows administrator login username (administrator is not allowed)
vm_size                   = "Standard_D2s_v5"             # Session host compute 
vnet_range                = ["10.13.1.0/24"]              # change to your cidr for the avd spoke vnet to be created
subnet_range              = ["10.13.1.0/26"]              # change to your cidr for the avd spoke subnet to be created
pesubnet_range            = ["10.13.1.192/27"]            # change to your cidr for avd spoke private endpoint subnet to be created
allow_list_ip             = ["13.22.43.118"]              # optional for access to browser resources with private endpoint you can add your IP address to allowlist
dns_servers               = ["10.0.1.6", "168.63.129.16"] # optional if you want to use your own DNS servers
next_hop_ip               = "10.100.0.4"                  # next hop ip address for route table
aad_group_name            = "alz-alztest-state-engineers" # user group must pre-created on your AD server and sync to Microsoft Entra ID
user_group_name           = "alz-alztest-state-engineers"
rdsh_count                = 2                                      # Number of session host vm to deploy
image_name                = "avdImage-win11-23h2-avd-m365"         # custom image name
image_rg                  = "rg-image-resources"                   # resource group for custom image and image gallery
gallery_name              = "avdgallery"                           # azure compute gallery name for custom image
hub_vnet                  = "hub-uksouth"                          # hub connectivity vnet name 
hub_connectivity_rg       = "vnethub-uksouth"                      # hub connectivity subscription network resource group
hub_dns_zone_rg           = "rg-privatedns"                        # private DNS zones resource group name
identity_rg               = "infra-rg"                             # identity subscription resource group
identity_vnet             = "infra-network"                        # identity subscription vnet name
fw_policy                 = "fwpol-hub"                            # firewall policy for AVD assumes that firewall is already deployed in hub subscription
spoke_subscription_id     = "2079258e-44c7-45cd-bb3d-bd27665a3a0c" # subscription where AVD resources will be deployed
hub_subscription_id       = "2079258e-44c7-45cd-bb3d-bd27665a3a0c" # subscription where hub resources are deployed (If you are using a single subscription for hub and spoke, use the same subscription id as spoke_subscription_id)
identity_subscription_id  = "2079258e-44c7-45cd-bb3d-bd27665a3a0c" # subscription where identity resources are deployed (If you are using a single subscription for hub and spoke, use the same subscription id as spoke_subscription_id)
avdshared_subscription_id = "2079258e-44c7-45cd-bb3d-bd27665a3a0c" # optional subscription where shared resources are deployed (If you are using a single subscription for hub and spoke, use the same subscription id as spoke_subscription_id)

## Session host Image options
# Marketplace Image
publisher = "MicrosoftWindowsDesktop"
offer     = "Windows-10"
sku       = "win10-22h2-avd-g2"
# Custom Image uncomment the following lines and comment the above lines to use custom image
# image_rg                  = "rg-image-resources"                   # resource group for custom image and image gallery
# gallery_name              = "avdgallery"                           # azure compute gallery name for custom image
# image_name                = "avdImage-win11-23h2-avd-m365"         # custom image name

############## Do not modify below this line unless you want to change naming convention#####################
# Resource Groups
rg_shared_name = "shared-resources" #output rg-avd-<Azure Region>-<prefix>-shared-resources
rg_network     = "network"          #rg-avd-<Azure Region>-<prefix>-network
rg_stor        = "storage"          #rg-avd-<Azure Region>-<prefix>-storage
rg_pool        = "pool-compute"     #rg-avd-<Azure Region>-<prefix>-pool-compute
rg_so          = "service-objects"  #rg-avd-<Azure Region>-<prefix>-service-objects
rg_avdi        = "monitoring"       #rg-avd-<Azure Region>-<prefix>-avdi
rg_image_name  = "image-resources"

# Azure Virtual Desktop Objects
## Host Pool Objects
hostpool     = "vdpool"  #vdpool-<azure region>-<prefix> multi-session host pool
personalpool = "vdppool" #vdpool-<azure region>-<prefix> personal host pool
raghostpool  = "vdrpool" #vdpool-<azure region>-<prefix> remote app group host pool

## Workspace Objects
workspace    = "vdws"  #vdmws-<azure region>-<prefix>-<nnn> AVD workspace for multi-session host pool
pworkspace   = "vdpws" #vdpws-<azure region>-<prefix>-<nnn> AVD workspace for personal host pool
ragworkspace = "vdrws" #vdrws-<azure region>-<prefix>-<nnn> AVD workspace for remote app group host pool

## Application Group Objects
pag = "vpag" #AVD personal pool desktop application group
dag = "vdag" #vdag-desktop-<azure region>-<prefix>-<nnn> AVD multi-session pool desktop application group 
rag = "vrag" #vdag-rapp-<azure region>-<prefix>-<nnn> AVD remote application pool desktop application group

## Diagnostic Settings for AVD Insights
host_pool_log_categories = ["Checkpoint", "Management", "Connection", "HostRegistration", "AgentHealthStatus", "NetworkData", "SessionHostManagement", "ConnectionGraphicsData", "Error"]
dag_log_categories       = ["Checkpoint", "Management", "Error"]
ws_log_categories        = ["Checkpoint", "Management", "Error", "Feed"]

## Scaling Plan Objects
scplan = "scaling-plan" #avd-<location>-<prefix>-scaling-plan

# Network Objects
rt     = "route-avd"  #route-avd-<azure region>-<prefix>-<nnn> Route Table
nsg    = "nsg-avd"    #nsg-avd-<azure region>-<prefix>-<nnn> Network Security Group
vnet   = "vnet-avd"   #vnet-avd-<azure region>-<prefix>-<nnn> Virtual Network
snet   = "snet-avd"   #snet-avd-<azure region>-<prefix>-<nnn> Subnet
pesnet = "pesnet-avd" #snet-avd-<azure region>-<prefix>-<nnn> Private Endpoint Subnet
