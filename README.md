# Local Gitops

- [Local Gitops](#local-gitops)
    - [Project Objective](#project-objective)
  - [Resources versioning](#resources-versioning)
    - [Avaliable Kubernetes services:](#avaliable-kubernetes-services)
    - [Tools required locally](#tools-required-locally)
      - [Installing requirements (*optional*)](#installing-requirements-optional)
    - [**Initializing the repository**](#initializing-the-repository)
    - [In case you want to reset the environment](#in-case-you-want-to-reset-the-environment)

---

### Project Objective

> The objective of this project is to furnish a streamlined method for establishing your own local cluster, complete with necessary utilities such as an image registry, garbage collectors, ingress configuration with TLS, and monitoring tools
>
> The project employs k3d to build a local cluster. k3d, a lightweight version of k3s, has the capacity to run all cluster components within containers, thus offering a more efficient local simulation alternative to Minikube or similar counterparts. Further, the project installs ArgoCD atop the k3d-created cluster, leveraging this repository as a resource for executing GitOps. It utilizes the code in the apps/ directory to generate and configure cluster resources.
> 
> Additionally, a multi-OS tool is configured to establish the DNS forwarding required for accessing cluster resources via hostnames rather than IP addresses. It employs `mkcert` to facilitate TLS/SSL-enabled requests towards your cluster ingresses, while continuing to operate exclusively on local resources.
> 
> Although the process is designed to be fully automated, users can delve into `tasks` to comprehend its operations. Taskfiles are easy to digest and they simply illustrate the commands executed at each automation phase.

## Resources versioning

```bash
- Kubernetes Version: v1.27.4-k3s1
- ArgoCD Version: v2.8.0
- k3d tested using v5.6 with v1alpha5 config file
```
### Avaliable Kubernetes services:

> - [ArgoCD][argocd-url] as the main GitOps tool | **Available at [argocd.k8s.localhost][argocd-localhost]**
> - Access to the cluster using [Nginx Ingress][nginx-url].
> - On-demand databases clusters with [Zalando Operator for PostgreSQL][postgres-url] | **UI available at [dbs.k8s.localhost][dbs-localhost]**
> - Hot-Reload secrets and configmaps to pods using [Reloader][reloader-url].
> - Mirror resources between namespaces using [Reflector][reflector-url].

### Tools required locally

> - [k3d][k3d-url] running atop of either (pick one):
>   - [Rancher Desktop **(Recommended)**][rancher-url]
>   - [Docker for Desktop][docker-url]
>   - [Podman][podman-url] (works but [requires extra steps][podman-steps])
> - [Task][task-url] as a more modern iteration of the Makefile utility
> - [mkcert][mkcert-url] for creating locally based TLS certificates for your ingress proxy
> - [kubectl][kubectl-url] | [kustomize][kustomize-url] | [helm][helm-url] to apply local commands to the cluster
> - [jq][jq-url] to manipulate the resulting JSON files and extract the required strings
> - [hostctl][hostctl-url] to create the local domain on your hosts file *(optional, but recommended)*

---

To list available commands, install [Task][task-installation-url] and run:
```sh
task help
```
#### Installing requirements (*optional*)
To install the required tools automatically <sub>(Requires [brew][brew-url] for Linux/MacOS and [Chocolatey][chocolate-url] for Windows.)</sub>

```sh
task tools:install
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
>  which will install the `task` binary for you and execute the command to run this repository's project by itself. <sub>(It might require **sudo**, please read the commands being executed before doing anything with elevated permissions on your work environment.)</sub>

### Where cluster resources are located

> - All PVCs files are configured to be stored in the repository [`storage/`][storage-uri] folder. In case you want backup your environment, simply copy these files to another location, and transfer them back when needed.
> - Local SSL/TLS certificates will be stored under the [`config/tls/`][tls-uri] folder. All of them are a part of the `.gitignore` file, in order to avoid being commited to your repository once created.


### In case you want to reset the environment

Whenever you want to restart from scratch and create a new cluster, just type `task` again.

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

<!--- Local URIs --->
[argocd-localhost]: https://argocd.k8s.localhost
[vault-localhost]: https://vault.k8s.localhost
[dbs-localhost]: https://dbs.k8s.localhost
