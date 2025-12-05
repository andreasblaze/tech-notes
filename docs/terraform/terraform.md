---
sidebar_position: 1
---

# Terrafom

## Versions Pinning
`version = "~> 1.0"` allows only the rightmost version component to increment. 
> For example, to allow new patch releases within a specific minor release, use the full version number: ~> **1.0.4** will allow installation of **1.0.5** and **1.0.10** but not **1.1.0**. This is usually called the pessimistic constraint operator (пессимистический оператор ограничения).
```bash
terraform {
  required_providers {
    mycloud = {
      source  = "mycorp/mycloud"
      version = "~> 1.0"
    }
  }
}
```
- != meaning “exactly not equal to”
- = meaning “exactly equal to”
- < meaning “less than”
```bash
terraform {
  required_version = ">= 0.12"
}
```

## Ternary Operators
In this case, the value of the `“example_variable”` variable will be `“value_if_true”` if the `“condition_met”` variable is **true**, and `“value_if_false”` otherwise.
```bash
variable "example_variable" {
  default = var.condition_met ? "value_if_true" : "value_if_false"
}
```

```bash
locals {
  files       = { for i in fileset("${path.module}/alert_rules/", "*.y*ml") : replace(basename(i), "/\\.y[a]?ml$/", "") => i }
  decoded_contents = [for file in local.files : try(yamldecode(file("${path.module}/rules/${file}")), [])]
}
```

## Functions

### flatten
Парсинг файлов

### lookup

### yamldecode

### coalesce
Принимает любое количество аргументов и возвращает первый из них, который не является нулевым значением или пустой строкой.
```bash
> coalesce("a", "b")
a
> coalesce("", "b")
b
> coalesce(1,2)
1
```

## CMD's
### terraform validate
Убедитесь, что файлы конфигурации Terraform синтаксически верны.
```bash
terraform validate
```

