### **Metrics Server**
```bash
# ---------------------------------------------------------------
# Install:
$ kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
$ kubectl get pods -n kube-system | grep metrics-server
# ---------------------------------------------------------------
# Uninstall:
$ kubectl delete -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```

### **Troubleshooting**

```bash
# ---------------------------------------------------------------
# Error:
"Failed to scrape node" err="Get \"https://192.168.65.4:10250/stats/summary?only_cpu_and_memory=true\": x509: cannot validate certificate for 192.168.65.4 because it doesn't contain any IP SANs" node="docker-desktop"
# Run:
$ kubectl patch deployment metrics-server -n kube-system --type 'json' -p '[{"op": "add", "path": "/spec/template/spec/containers/0/args/-", "value": "--kubelet-insecure-tls"}]'
# ---------------------------------------------------------------

```