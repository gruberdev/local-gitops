## Local ArgoCD workbench

### Prerequisites
We are using [nix](https://nixos.org/) to manage our dependencies.

Enter the shell to proceed
```
nix develop
```

### Install a new K3d cluster + ArgoCD
You need your GitHub username and an access token
```
export GH_USER=...
export GH_PASS=...
task
```
Copy a new password from log output

Open ArgoCD UI and login with `admin` and your generated password
```
https://argocd.k8s.localhost:8832
```

### Utilities
Forward ArgoCD UI
```
task argocd:forward
```

Generate new password for ArgoCD
```
task argocd:password
```

#### Cluster
```
task start
task stop
```

### Creating a PR generator
Create a new PR generator
```
task templates:pr_gen
```