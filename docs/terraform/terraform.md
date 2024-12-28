---
sidebar_position: 1
---

# Terrafom

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

