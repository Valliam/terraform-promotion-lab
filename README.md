# Terraform Promotion Lab

Hands-on lab for learning a production-style Terraform flow:

`feature branch -> pull request -> plan dev/staging/prod -> merge -> apply dev -> promote staging -> promote prod`

## Safety model

- Every infrastructure PR plans **all three environments** so reviewers can see cross-environment impact before merge.
- Merge to `main` automatically applies **DEV only**.
- Each successful deployment records a GitHub deployment receipt tied to the exact commit SHA.
- Staging promotion requires that exact SHA to have a successful DEV deployment receipt.
- Prod promotion requires that exact SHA to have a successful staging deployment receipt.
- Each environment has a concurrency lock so two Terraform applies cannot run against the same environment at the same time.
- GitHub Actions are pinned to exact commit SHAs rather than floating version tags.
- Sensitive paths have CODEOWNERS entries.

## Lab limitation

This repository intentionally uses local Terraform state and uploads it as a GitHub Actions artifact so the lab stays free and does not touch a real cloud account. **Do not use workflow artifacts as a production Terraform backend.**

A real implementation should use HCP Terraform or a remote backend such as Azure Blob Storage, with separate state, OIDC/federated identities, and least-privilege cloud permissions for dev, staging, and production.

## Recommended GitHub settings

For a production repository, protect `main`, require the Terraform plan checks before merge, and configure the `prod` GitHub Environment with required reviewers. In an organization, CODEOWNERS should point to a platform/security team rather than a single repository owner.
