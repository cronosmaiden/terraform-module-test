# Módulo Lambda - Terraform

Este módulo crea una función Lambda en AWS.

## Requisitos

- Terraform v1.5.2
- Provider AWS v5.45.0

## Variables

- `lambda_function_name`: Nombre de la función Lambda (string).
- `lambda_function_role`: ARN del rol de ejecución (string).
- ... *(ver archivo variables.tf)*

## Outputs

- `lambda_arn`: ARN de la Lambda.
- `lambda_name`: Nombre de la Lambda.
