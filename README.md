# Título pendiente...

## Prerrequisitos

VitualBox y Vagrant y autorizaciones necesarios para lanzar máquinas virtuales  

## Instalación
    cd
    git clone https://github.com/carmelocuenca/openstack.git
    cd openstack
    vagrant up

La infraestructura virtual desplegada consta de tres máquinas: "controller", "network" y "compute".
Cada una con ip's 10.0.10.11, 10.0.10.12 y 10.0.10.13 respectivamente.

También existen 3 redes privadas:

- Management: 10.0.10.0 para todos los nodos ("controller", ...)
- Tunnel: 10.0.11.0  para los nodos "network"
- Compute: 10.0.12.0 para los nodos "compute"

## Provisionamiento

- Paquete ntp para todos los nodos
