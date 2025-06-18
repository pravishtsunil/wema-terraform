
# Terraform Infrastructure Automation with GitHub Actions

This repository uses **GitHub Actions** to automatically run Terraform plans and applies for three environments: **dev**, **uat**, and **prod**.

---

## 📁 Directory Structure

```
.
├── Terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── dev.tfvars
│   ├── uat.tfvars
│   └── prod.tfvars
├── .github/
│   └── workflows/
│       ├── terraform.yml             # Main workflow calling reusable workflows
│       ├── aws_tf_plan.yml           # Reusable Plan workflow
│       └── aws_tf_appy.yml           # Reusable Apply workflow
```

---

## 🚀 Environments

Three separate environments are supported:
- `dev`
- `uat`
- `prod`

Each environment must have:
- A corresponding `.tfvars` file (`dev.tfvars`, `uat.tfvars`, `prod.tfvars`)
- A remote state key (in S3) like `dev/terraform.tfstate`, `uat/terraform.tfstate`, etc.
- Environment-specific configurations in GitHub Actions.

---

## 🔐 Required GitHub Secrets

Go to **Repository Settings → Secrets and variables → Actions → New repository secret** and add the following secrets:

| Secret Name              | Description                                  |
|--------------------------|----------------------------------------------|
| `AWS_ACCESS_KEY_ID`      | Your AWS IAM user's access key ID            |
| `AWS_SECRET_ACCESS_KEY`  | Your AWS IAM user's secret access key        |
| `AWS_REGION`             | AWS region where resources will be created   |
| `TF_STATE_BUCKET`        | Name of your S3 bucket to store `.tfstate`   |

These secrets are used in both the plan and apply workflows to authenticate and configure AWS backend.

---

## 📦 Terraform Variable Management

- Define **all variables** in `variables.tf`:

```hcl
variable "environment" {
  description = "The deployment environment"
  type        = string
}
```

- Then, specify values in each tfvars file:

**`dev.tfvars`**
```hcl
environment = "dev"
```

**`uat.tfvars`**
```hcl
environment = "uat"
```

**`prod.tfvars`**
```hcl
environment = "prod"
```

---

## ⚙️ How It Works

### 1. `terraform.yml` (Main Workflow)
This file triggers `plan` and `apply` stages for all environments when you push to `main`.

### 2. `aws_tf_plan.yml` (Reusable Plan Workflow)
- Sets up AWS + Terraform
- Configures remote backend
- Runs `terraform init`, `validate`, `plan`
- If plan fails, the job fails

### 3. `aws_tf_appy.yml` (Reusable Apply Workflow)
- Used only when `plan` is successful
- Runs `terraform apply` with `-auto-approve`

---

## 🧪 Trigger the Workflow

You can trigger the workflow by:
- Committing changes to `main` branch
- Or manually via the **Actions → Run workflow** button

---

## ✅ Example Commit Flow

1. Modify infrastructure in `Terraform/main.tf`
2. Update tfvars if needed (`dev.tfvars`, etc.)
3. Push to `main`
4. GitHub Actions will automatically:
   - Run plan for each environment
   - If successful, apply for each environment

---

## 🔍 Debugging Tips

- Check workflow logs in **Actions** tab
- Confirm `backend.tf` is created properly
- Check your S3 bucket for `dev/terraform.tfstate`, etc.

---


