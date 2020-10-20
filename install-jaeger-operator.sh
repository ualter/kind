clear
echo " --> Installing Jaeger Operator "
kubectl create namespace observability
kubectl create -n observability -f https://raw.githubusercontent.com/jaegertracing/jaeger-operator/master/deploy/crds/jaegertracing.io_jaegers_crd.yaml
kubectl create -n observability -f https://raw.githubusercontent.com/jaegertracing/jaeger-operator/master/deploy/service_account.yaml
kubectl create -n observability -f https://raw.githubusercontent.com/jaegertracing/jaeger-operator/master/deploy/role.yaml
kubectl create -n observability -f https://raw.githubusercontent.com/jaegertracing/jaeger-operator/master/deploy/role_binding.yaml
kubectl create -n observability -f https://raw.githubusercontent.com/jaegertracing/jaeger-operator/master/deploy/operator.yaml
# Cluster-wide Permissions Extra Features
kubectl create -f https://raw.githubusercontent.com/jaegertracing/jaeger-operator/master/deploy/cluster_role.yaml
kubectl create -f https://raw.githubusercontent.com/jaegertracing/jaeger-operator/master/deploy/cluster_role_binding.yaml

echo ""
echo "Creating an Instance of Jaeger"
kubectl apply -n observability -f - <<EOF
apiVersion: jaegertracing.io/v1
kind: Jaeger
metadata:
  name: simplest
EOF

kubectl get all -n observability

#####################
### More Info studied
#####################

# Deploymenht of Jaeger as a Daemonset
#apiVersion: jaegertracing.io/v1
# kind: Jaeger
# metadata:
#   name: my-jaeger
# spec:
#   agent:
#     strategy: DaemonSet
# Informing the Agent Location to the App
#  ...
#  spec:
#       containers:
#       - name: myapp
#         image: acme/myapp:myversion
#         env:
#         - name: JAEGER_AGENT_HOST
#           valueFrom:
#             fieldRef:
#               fieldPath: status.hostIP


# Deployment of Jaeger more "Production" prepared
# apiVersion: jaegertracing.io/v1
# kind: Jaeger
# metadata:
#   name: simple-prod
# spec:
#   strategy: production
#   collector:
#     maxReplicas: 5
#     resources:
#       limits:
#         cpu: 100m
#         memory: 128Mi
#   storage:
#     type: elasticsearch
#     options:
#       es:
#         server-urls: http://elasticsearch:9200



# Jaeager has Agents (although it is possible to use without the, it is recommended to use them, reasons: https://www.jaegertracing.io/docs/1.19/faq/#do-i-need-to-run-jaeger-agent )
# Jaeger, the agent Jaeger in Kubernetes can work either as a Sidecar or a Daemonset
# Zipkin hasn't Agents, it is uses client instrumentation to do the tracing, and the client must send to Zipkin Server the collect data