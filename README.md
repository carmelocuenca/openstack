# Título pendiente...

## Prerrequisitos

VitualBox y Vagrant y autorizaciones necesarios para  

## Instalación
    cd
    git clone https://github.com/carmelocuenca/openstack.git
    cd openstack
    vagrant up

La infraestructura virtual desplegada consta de tres máquinas: "controller", "network" y "compute".
Cada una con ip's 10.0.0.11, 10.0.0.12 y 10.0.0.13 respectivamente.

También existen 3 redes privadas:

- Management: 10.0.0 para todos los nodos ("controler", ...)
- Tunnel: 10.0.1.0  para los nodos "network"
- Compute: 10.0.2.0 para los nodos "compute"
