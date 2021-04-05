variable "dfWrules" {

  type = map(object({ src = list(string), dest = string, srv = string, action = string }))
  default = {

    Any_T3_ICMP = { src = ["3-Tier","App-Servers"], dest = "/infra/domains/default/groups/3-Tier", srv = "/infra/services/ICMP-ALL", action = "ALLOW" },
    Any_SSH = {src = ["3-Tier","DB-Servers","Web-Servers"], dest = "/infra/domains/default/groups/3-Tier", srv = "/infra/services/ICMP-ALL", action = "ALLOW" }




  }

}