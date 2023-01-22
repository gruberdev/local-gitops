# Local Gitops

### Project Objective

> The goal of this project is to provide a simplified approach to creating your own local cluster, as well all the utilities you'll need to run a functional cluster, such as a image registry, garbage collectors, ingress configuration with tls and monitoring tools.
>
> It is also meant to provide a way for newcomers on the area both access to a functional GitOps configuration, and the capability to run it easily, to understand how it works in practice.
## Resources

```bash
Kubernetes Version: v1.26.0-k3s2
```
### Avaliable Kubernetes services:

> - [ArgoCD][argocd-url] as the main GitOps tool | **Available at [argocd.k8s.localhost][argocd-localhost]**
> - Access to the cluster using [Nginx Ingress][nginx-url].
> - On-demand databases clusters with [Zalando Operator for PostgreSQL][postgres-url] | **UI available at [dbs.k8s.localhost][dbs-localhost]**
> - Hot-Reload secrets and configmaps to pods using [Reloader][reloader-url].
> - Metrics monitoring with [Prometheus's Stack][prometheus-url] (Also includes [Grafana][grafana-url])
> - Mirror resources between namespaces using [Reflector][reflector-url].
> - Image caching for hot-swapping using [Kube-fledged][kubefledged-url]. (Only useful for multi-node k3d setups)

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
#### Initializing the repository

> **First: You have to fork this repository**. 
>
> The [task][task-url] commands will ensure the repository is correctly configured once you run the bootstrapping command.
>
> cd into your forked repository, then run:
```sh
task
```


---

### Plan to use but are not k3d-compatible for now:
- **Storage:** [Longhorn][longhorn-url], require iscsi-compatible drivers. See [Using Longhorn in k3d #478][longhorn-issue].
  - Alternative: Local Volumes. Uncomment `config/cluster.yaml` lines 31-36.
- **Cluster Backup:** [Velero][velero-url], requires compatible storage provider. See [the official compatible list][velero-list-url].
  - Alternative: [kube-dump][kube-dump-url] backup a k8s cluster as yaml manifests
  - Alternative: [Stash][stash-url], specifically for stateful applications.

<!--- References --->
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
[podman-steps]: https://k3d.io/v5.4.1/usage/advanced/podman/
[hostctl-url]: https://github.com/guumaster/hostctl
[kustomize-url]: https://kubectl.docs.kubernetes.io/installation/kustomize/
[helm-url]: https://helm.sh/docs/intro/install/
[chocolate-url]: https://chocolatey.org/install
[brew-url]: https://brew.sh/

<!--- Local URIs --->
[argocd-localhost]: https://argocd.k8s.localhost
[vault-localhost]: https://vault.k8s.localhost
[dbs-localhost]: https://dbs.k8s.localhost
