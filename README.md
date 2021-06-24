# Red Hat Integration Gitops
Proyecto de ejemplo para GitOps

# Crear las imágenes

> Para crear las imágenes en un repositorio externo se pueden seguir los siguientes pasos

## Crear la imagen es de Consulta Saldo Gateway

> Crear la estructura del source to image, si se usa la carpeta de este repositorio este comando se debe excluir

```
s2i create consulta-saldo-gateway s2i-consulta-saldo-gateway
```

> Entrar a la carpeta creada
```
cd s2i-consulta-saldo-gateway/
```

> Modificar el dockerfile y copiar los archivos necesarios para la personalización, en los archivos de este repositorio se puede ver el Dockerfile de ejemplo, si se usa la carpeta de este repositorio este comando se debe excluir

> Verificar las imagenes actuales
```
podman images
```

> Autenticarse en el registry de red hat con las credenciales de https://access.redhat.com/terms-based-registry/ para usar la imágen base del registry de Red Hat
```
podman login registry.redhat.io
```

> Construir la nueva imagen con el dockerfile personalizado y los nuevos archivos
```
podman build -t consulta-saldo-gateway .
```

> Verificar que la nueva imagen se creo y sacar el ID
```
podman images
```

> Verificar que la nueva imagen tiene los archivos, en el comando se debe cambiar el **{{ID}}**
```
podman run {{ID}} ls /deployments
```

> Login a quay.io, en el comando se debe cambiar el **{{user_quay}}**
```
podman login -u {{user_quay}} quay.io
```

> Subir la imagen al repositorio externo de quay.io, en el comando se debe cambiar el **{{ID}}** y el **{{user_quay}}**
```
podman push <ID> docker://quay.io/<user_quay>/consulta-saldo-gateway:1.0
```
  
> Autenticarse en OCP, en el comando se debe cambiar el **{{host_api_ocp}}**, **{{username_ocp}** y **{{clave}}**
```
oc login --server=https://{{host_api_ocp}}:6443 --username={{username_ocp}} --password={{clave}} --insecure-skip-tls-verify=true
```

> Cambiarse a la raíz del repositorio
```
cd ..
```

> Crear la app en ArgoCD
```
oc apply -f argocd/consulta-saldo-gateway-app.yaml
```

  
## Crear la imagen es de Consulta Saldo

> Crear la estructura del source to image, si se usa la carpeta de este repositorio este comando se debe excluir

```
s2i create consulta-saldo s2i-consulta-saldo
```

> Entrar a la carpeta creada
```
cd s2i-consulta-saldo/
```

> Modificar el dockerfile y copiar los archivos necesarios para la personalización, en los archivos de este repositorio se puede ver el Dockerfile de ejemplo, si se usa la carpeta de este repositorio este comando se debe excluir

> Verificar las imagenes actuales
```
podman images
```

> Autenticarse en el registry de red hat con las credenciales de https://access.redhat.com/terms-based-registry/ para usar la imágen base del registry de Red Hat
```
podman login registry.redhat.io
```

> Construir la nueva imagen con el dockerfile personalizado y los nuevos archivos
```
podman build -t consulta-saldo .
```

> Verificar que la nueva imagen se creo y sacar el ID
```
podman images
```

> Verificar que la nueva imagen tiene los archivos, en el comando cambiar el ID
```
podman run <ID> ls /deployments
```

> Login a quay.io
```
podman login -u <user_quay> quay.io
```

> Subir la imagen al repositorio externo de quay.io
```
podman push <ID> docker://quay.io/<user_quay>/consulta-saldo:1.0
```

> Autenticarse en OCP
```
oc login --server=https://<host_api_ocp>:6443 --username=<username_ocp> --password=<clave> --insecure-skip-tls-verify=true
```

> Cambiarse a la raíz del repositorio
```
cd ..
```

> Crear la app en ArgoCD
```
oc apply -f argocd/consulta-saldo-app.yaml
```

## Author

* **Lázaro Miguel Coronado Torres** - *Middleware Senior Consultant - lcoronad@redhat.com* 
