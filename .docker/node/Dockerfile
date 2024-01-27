FROM node:18-slim

# Définir les arguments pour l'UID et le GID
ARG USER_ID=1000
ARG GROUP_ID=1000

# Mise à jour des paquets et installation des outils nécessaires
RUN apt-get update \
   && apt-get autoremove -y \
   && apt-get clean all \
   && rm -rf /var/lib/apt/lists/*

# Accorder des capacités spécifiques à Node.js
# RUN setcap cap_net_bind_service=+ep `readlink -f \`which node\``

# Modifier l'UID et le GID de l'utilisateur 'node'
RUN groupmod -g ${GROUP_ID} node && \
    usermod -u ${USER_ID} -g ${GROUP_ID} node

# Définir le répertoire de travail
WORKDIR /var/www/html

EXPOSE 3000

# Copier le script de démarrage
COPY startup.sh /var/bin/startup.sh

# Définir la commande de démarrage
CMD ["/bin/bash", "/var/bin/startup.sh"]
