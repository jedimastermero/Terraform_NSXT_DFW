resource "nsxt_policy_security_policy" "policy2" {
  category     = "Application"
  display_name = "TF-Policy-2"
  stateful     = true
  tcp_strict   = true


dynamic "rule" {
    for_each = var.dfWrules

    content {

      display_name  = rule.key
      source_groups = [for de in rule.value.src : lookup(data.nsxt_policy_group.srcgrp,de).path]
      destination_groups = [rule.value.dest]
      action = rule.value.action
      services = [rule.value.srv]

    }
  }
}
data "nsxt_policy_group" "srcgrp" {
  for_each = toset(local.soso)
  display_name = each.value
}

output "grpinfo" {
  value = data.nsxt_policy_group.srcgrp
}
locals {

  soso = flatten([ for key, valu in var.dfWrules : lookup(valu,"src" )])
}

output "tests" {
  value = local.soso
}