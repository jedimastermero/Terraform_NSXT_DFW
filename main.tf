resource "nsxt_policy_security_policy" "policy2" {
  category     = "Application"
  display_name = "TF-Policy-2"
  stateful     = true
  tcp_strict   = true


dynamic "rule" {
    for_each = var.dfWrules

    content {

      display_name  = rule.key
      source_groups = [for sr in rule.value.src : lookup(data.nsxt_policy_group.srcgrp,sr).path]
      destination_groups = [rule.value.dest]
      action = rule.value.action
      services = [rule.value.srv]

    }
  }
}
data "nsxt_policy_group" "srcgrp" {
  for_each = toset(local.in_src_grp)
  display_name = each.value
}


locals {

  in_src_grp = flatten([ for key, val in var.dfWrules : lookup(val,"src" )])
}

output "testing" {
  value = local.in_src_grp
}
output "grpinfo" {
  value = data.nsxt_policy_group.srcgrp
}