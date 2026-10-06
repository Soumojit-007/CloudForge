## 🏗️ Core Stack

| Technology          | Purpose                                            |
| ------------------- | -------------------------------------------------- |
| **Azure**           | Cloud platform where the infrastructure runs       |
| **Terraform**       | Infrastructure as Code (IaC)                       |
| **Docker**          | Containerizes the application                      |
| **Kubernetes**      | Orchestrates and manages containers                |
| **AKS**             | Azure's managed Kubernetes service                 |
| **ACR**             | Stores Docker/container images                     |
| **GitHub**          | Source code and GitOps repositories                |
| **Azure DevOps**    | CI/CD and Terraform automation                     |
| **Argo CD**         | GitOps continuous delivery                         |
| **Azure Key Vault** | Securely stores secrets, keys, and certificates    |
| **VNet**            | Azure virtual networking                           |
| **NSG**             | Network security and firewall rules                |
| **Azure Monitor**   | Infrastructure and application monitoring and logs |



cloudforge-infra/
│
├── terraform/
│   │
│   ├── modules/
│   │   ├── resource-group/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   │
│   │   ├── networking/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   │
│   │   ├── acr/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   │
│   │   ├── aks/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   │
│   │   ├── key-vault/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   │
│   │   └── monitoring/
│   │       ├── main.tf
│   │       ├── variables.tf
│   │       └── outputs.tf
│   │
│   └── environments/
│       │
│       ├── dev/
│       │   ├── main.tf
│       │   ├── variables.tf
│       │   ├── outputs.tf
│       │   ├── providers.tf
│       │   ├── backend.tf
│       │   └── terraform.tfvars
│       │
│       └── prod/
│           ├── main.tf
│           ├── variables.tf
│           ├── outputs.tf
│           ├── providers.tf
│           ├── backend.tf
│           └── terraform.tfvars
│
├── pipelines/
│   ├── terraform-plan.yml
│   └── terraform-apply.yml
│
├── .gitignore
├── README.md
└── azure-pipelines.yml





cloudforge-app/
│
├── backend/
│   ├── src/
│   ├── tests/
│   ├── requirements.txt
│   └── Dockerfile
│
├── frontend/
│   ├── src/
│   ├── package.json
│   └── Dockerfile
│
├── docker-compose.yml
│
├── .github/
│   └── ...
│
├── .gitignore
└── README.md



cloudforge-gitops/
│
├── apps/
│   │
│   └── cloudforge/
│       ├── namespace.yaml
│       ├── deployment.yaml
│       ├── service.yaml
│       ├── ingress.yaml
│       ├── configmap.yaml
│       └── secret.yaml
│
├── argocd/
│   │
│   ├── application.yaml
│   └── project.yaml
│
├── environments/
│   │
│   ├── dev/
│   │   └── kustomization.yaml
│   │
│   └── prod/
│       └── kustomization.yaml
│
├── README.md
└── .gitignore



cloudforge/
│
├── infrastructure/
│   └── Terraform + Azure
│
├── application/
│   ├── frontend/
│   └── backend/
│
├── gitops/
│   ├── kubernetes/
│   └── argocd/
│
├── pipelines/
│   ├── terraform/
│   └── application/
│
├── docker-compose.yml
│
├── README.md
└── .gitignore



Resource Group ✅
       ↓
Networking      ✅
       ↓
ACR             ✅
       ↓
AKS             ← NEXT
       ↓
Key Vault
       ↓
Monitoring



ACR
 │
 ├── cloudforge-backend:v1
 └── cloudforge-frontend:v1
             │
             ▼
            AKS
             │
       ┌─────┴─────┐
       │           │
   Backend       Frontend
    Pod(s)        Pod(s)
       │           │
   Service       Service


                       Azure
                      │
                 ┌────▼────┐
                 │   AKS   │
                 └────┬────┘
                      │
          ┌───────────┴───────────┐
          │                       │
   ┌──────▼──────┐        ┌──────▼──────┐
   │   Frontend  │        │   Backend   │
   │ React/Nginx │        │    Flask    │
   │   :80       │        │   :5000     │
   └──────┬──────┘        └─────────────┘
          │
    LoadBalancer
          │
     Public IP