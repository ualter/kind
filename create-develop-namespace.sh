
echo ""
echo "****************************"
echo " Creating Develop Namespace "
echo "****************************"
echo "kind: Cluster" >> develop-namespace.yaml
echo "apiVersion: v1" >> develop-namespace.yaml
echo "kind: Namespace" >> develop-namespace.yaml
echo "metadata:" >> develop-namespace.yaml
echo "  name: develop" >> develop-namespace.yaml
kubectl apply -f develop-namespace.yaml
rm develop-namespace.yaml
