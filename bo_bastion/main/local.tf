locals {
  common_tags = {
    CostCentre    = var.tag_CostCentre
    ApplicationId = var.tag_ApplicationId   # ← consistent casing
    SupportGroup  = var.tag_SupportGroup    # ← add missing tag
    Owner         = var.tag_Owner
    AppCategory   = var.tag_AppCategory
    Environment   = var.tag_Environment
    ManagedBy     = "Terraform"             # ← add static tag
  }
}