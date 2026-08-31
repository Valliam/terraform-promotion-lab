# Lab Guide

## What this lab simulates

A Data & AI platform team manages a Databricks-style energy forecast workload with Terraform.

- Pull request: `terraform plan` against DEV only.
- Merge to `main`: DEV is automatically applied.
- Staging: manually promote the exact commit SHA that passed DEV.
- Production: manually promote the same exact commit SHA.

## Environment isolation

Each environment has a separate Terraform root module:

- `infra/envs/dev`
- `infra/envs/staging`
- `infra/envs/prod`

Because Terraform state belongs to the root module/backend, these roots are separate state boundaries. In this safe lab the state is local to each GitHub runner and uploaded only as an artifact for inspection. Do **not** copy this state approach to production.

A real implementation would normally use separate HCP Terraform workspaces or separate Azure Blob backend keys/containers, plus separate cloud identities for DEV/STAGING/PROD.

## Why merge only changes DEV

The `Deploy DEV` workflow is triggered by a push to `main` and its Terraform working directory is hard-coded to `infra/envs/dev`. It literally never runs Terraform from the staging or prod root modules.

## Promotion

The `Promote Release` workflow is manual (`workflow_dispatch`). You select `staging` or `prod` and paste the exact commit SHA that already passed DEV. The workflow checks out that exact Git commit, so the configuration being promoted is identical to the version tested in DEV.

For a production-grade repository, configure GitHub Environment protection so `prod` requires an approver before the job may run.
