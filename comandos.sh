# redhat-integration-gitops
Proyecto de ejemplo para GitOps

# Autenticarse en OCP
oc login --server=https://api.cluster-0f15.dynamic.opentlc.com:6443 --username=admin --password=TQFWpWzKZ89by62B --insecure-skip-tls-verify=true

#ArgoCD 
#Username: admin
#Password: zBLaMPtFJDyvcCRdHI1Ege4f9won7kW8

#Crear la estructura del source to image
s2i create consulta-saldo-gateway s2i-consulta-saldo-gateway
#Entrar a la carpeta creada
cd s2i-consulta-saldo-gateway/
#Modificar el dockerfile y copiar los archivos necesarios para la personalización
#Verificar las imagenes actuales
podman images
#Autenticarse en el registry de red hat con las credenciales de https://access.redhat.com/terms-based-registry/
podman login registry.redhat.io
#Construir la nueva imagen con el dockerfile personalizado y los nuevos archivos
podman build -t consulta-saldo-gateway .
#Verificar que la nueva imagen se creo y sacar el ID
podman images
#Verificar que la nueva imagen tiene los archivos, en el comando cambiar el ID f5e2d471ab05
podman run <ID> ls /deployments
#Realizar el tag de la imagen
#podman tag redhat-sso74-banesco-openshift docker-registry.default.svc:5000/openshift/redhat-sso74-banesco-openshift:1.0
#Login a quay.io
podman login -u lcoronad quay.io
#Subir la imagen al repositorio externo de quay.io
podman push <ID> docker://quay.io/lcoronad/consulta-saldo-gateway:1.0
#Crear el secret para que se autentique en quay.io
oc create secret generic quay-registry --from-file .dockerconfigjson=/run/user/1002/containers/auth.json --type kubernetes.io/dockerconfigjson
#Crear la app en ArgoCD
oc apply -f argocd/consulta-saldo-gateway-app.yaml




#Entrar a la carpeta creada
cd s2i-consulta-saldo/
#Modificar el dockerfile y copiar los archivos necesarios para la personalización
#Verificar las imagenes actuales
podman images
#Autenticarse en el registry de red hat con las credenciales de https://access.redhat.com/terms-based-registry/
podman login registry.redhat.io
#Construir la nueva imagen con el dockerfile personalizado y los nuevos archivos
podman build -t consulta-saldo .
#Verificar que la nueva imagen se creo y sacar el ID
podman images
#Verificar que la nueva imagen tiene los archivos, en el comando cambiar el ID f5e2d471ab05
podman run <ID> ls /deployments
#Realizar el tag de la imagen
#podman tag redhat-sso74-banesco-openshift docker-registry.default.svc:5000/openshift/redhat-sso74-banesco-openshift:1.0
#Login a quay.io
podman login -u lcoronad quay.io
#Subir la imagen al repositorio externo de quay.io
podman push <ID> docker://quay.io/lcoronad/consulta-saldo:1.0
#Crear el secret para que se autentique en quay.io
oc create secret generic quay-registry --from-file .dockerconfigjson=/run/user/1002/containers/auth.json --type kubernetes.io/dockerconfigjson
#Crear la app en ArgoCD
oc apply -f argocd/consulta-saldo-app.yaml
