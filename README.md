# Local Gitops

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/gruberdev/local-gitops)

### Project goal

> This repo was created to give operators a practical way to spin up a local Kubernetes cluster using [k3d][k3d-url], which runs k3s in containers - a lightweight version of the standard Kubernetes. You get all the essentials: a private image registry, a GitOps repository and a TLS-secured ingress and [it is faster to iterate environments than using Minikube][k3d-benchs].
>
> The setup uses ArgoCD for GitOps, pulling configurations from the apps directory to manage your resources. For convenience, there's local DNS forwarding so you can access everything by hostname, and mkcert handles TLS certificates automatically to your `localhost`-based domains.
>
> [The repository is automated through Taskfiles][tasks-internal], so deployment is straightforward, but you can still dig into individual tasks if you want to understand what's happening under the hood.

## Current components versioning

```bash
 Kubernetes Version: v1.32.2-k3s1
 ArgoCD Version: v2.14.7
 k3d tested using v5.8.3 v1alpha5 config file
```
### Avaliable Kubernetes services:

> - [ArgoCD][argocd-url] as the main GitOps tool | **Available at [argocd.k8s.localhost][argocd-localhost]**
> - [Example][example-url] application | **Available at [whoami.k8s.localhost][example-localhost]**
> - Access to the cluster using [Nginx ingress controller][nginx-url].
> - Mirror resources between namespaces using [Reflector][reflector-url].

 ### Tools required on the host system

> - [k3d][k3d-url] running atop of either (pick one):
>   - [Rancher Desktop **(Recommended)**][rancher-url]
>   - [Docker for Desktop][docker-url]
>   - [Podman][podman-url] <sub>(works but [requires extra steps][podman-steps])</sub>
> - [Task][task-url] as a more modern iteration of the Makefile utility
> - [mkcert][mkcert-url] to create local TLS certificates
> - [kubectl][kubectl-url] | [kustomize][kustomize-url] | [helm][helm-url] to apply local commands to the cluster
> - [hostctl][hostctl-url] to create the local domain on your hosts file *(optional, but recommended)*

---

To list available commands, install [Task][task-installation-url] and run:
```sh
task help
```
#### Installing requirements (*optional*)
To install the required tools automatically <sub>(Requires [brew][brew-url] for MacOS and [Chocolatey][chocolate-url] for Windows.)</sub>

```sh
task tools
```

---

### **Initializing the repository**

> **First: You have to fork this repository**.
>
> The [task][task-url] commands will ensure the repository is correctly configured once you run the bootstrapping command.
>
> cd into your forked repository, then run:
>
> ```sh
> task
>  ```
>
> If you don't have `task` installed, you can run
> ```sh
>  make
>  ```
>  which will install the `task` binary for you and execute the command to run this repository's project by itself.
>
><sub>(It might require **sudo**, please read the commands being executed before doing anything with elevated permissions on your work environment.)</sub>

### Where cluster resources are located?

> - All PVCs files are configured to be stored in the repository [`storage/`][storage-uri] folder. In case you want backup your environment, simply copy these files to another location, and transfer them back when needed.
> - Local SSL/TLS certificates will be stored under the [`config/tls/`][tls-uri] folder. All of them are a part of the `.gitignore` file, in order to avoid being commited to your repository once created.


### How do I reset the environment?

> Whenever you want to restart from scratch and create a new cluster, just type `task` again. This process will destroy the previous cluster and create a new from scratch.

<!---
> - Metrics monitoring with [Prometheus's Stack][prometheus-url] (Also includes [Grafana][grafana-url])
-->
<!--- References --->
[tls-uri]: https://github.com/gruberdev/local-gitops/tree/main/config/tls
[storage-uri]: https://github.com/gruberdev/local-gitops/tree/main/storage
[argocd-url]: https://argo-cd.readthedocs.io/en/stable/
[nginx-url]: https://github.com/kubernetes/ingress-nginx
[vault-url]: https://github.com/hashicorp/vault
[vault-plugin-url]: https://github.com/argoproj-labs/argocd-vault-plugin
[postgres-url]: https://github.com/zalando/postgres-operator
[reloader-url]: https://github.com/stakater/Reloader
[prometheus-url]: https://github.com/prometheus-operator/kube-prometheus
[grafana-url]: https://github.com/grafana/grafana
[kube-cleanup-url]: https://github.com/lwolf/kube-cleanup-operator
[reflector-url]: https://github.com/emberstack/kubernetes-reflector
[kubefledged-url]: https://github.com/senthilrch/kube-fledged
[descheduler-url]: https://github.com/kubernetes-sigs/descheduler
[kwatch-url]: https://github.com/abahmed/kwatch
[botkube-url]: https://github.com/infracloudio/botkube
[kubenurse-url]: https://github.com/postfinance/kubenurse
[longhorn-url]: https://longhorn.io/
[longhorn-issue]: https://github.com/rancher/k3d/discussions/478
[velero-url]: https://velero.io/
[velero-list-url]: https://velero.io/docs/v1.7/supported-providers/
[kube-dump-url]: https://github.com/WoozyMasta/kube-dump
[stash-url]: https://stash.run/
[task-url]: https://taskfile.dev
[task-installation-url]: https://taskfile.dev/installation/
[mkcert-url]: https://github.com/FiloSottile/mkcert
[kubectl-url]: https://kubernetes.io/docs/tasks/tools/
[jq-url]: https://stedolan.github.io/jq/download/
[k3d-url]: https://k3d.io
[docker-url]: https://www.docker.com/products/docker-desktop/
[rancher-url]: https://rancherdesktop.io/
[podman-url]: https://podman.io/
[podman-steps]: https://k3d.io/v5.6.0/usage/advanced/podman/
[hostctl-url]: https://github.com/guumaster/hostctl
[kustomize-url]: https://kubectl.docs.kubernetes.io/installation/kustomize/
[helm-url]: https://helm.sh/docs/intro/install/
[chocolate-url]: https://chocolatey.org/install
[brew-url]: https://brew.sh/
[example-url]: https://github.com/gruberdev/local-gitops/tree/main/apps/example


<!--- Internal Git URIs -->
[tasks-internal]: https://github.com/gruberdev/local-gitops/tree/main/.tasks
[k3d-benchs]: https://minikube.sigs.k8s.io/docs/benchmarks/imagebuild/minikubevsothers/

<!--- Local URIs --->
[argocd-localhost]: https://argocd.k8s.localhost
[example-localhost]: https://whoami.k8s.localhost
