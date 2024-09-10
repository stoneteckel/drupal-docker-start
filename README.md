# Projet Drupal avec Docker

Ce projet utilise Docker pour configurer un environnement de développement Drupal avec PHP 8.3, MySQL (MariaDB) et Apache. 

## Prérequis

Avant de commencer, assurez-vous d'avoir les outils suivants installés sur votre machine :

- Docker
- Docker Compose
- Composer

## Configuration du Projet

1. **Cloner le Répertoire**

   Clonez le dépôt Git contenant les fichiers du projet :

   ```
   $ git clone <URL_DU_DEPOT_GIT>
   $ cd <NOM_DU_REPERTOIRE_CLONÉ>
   ```

2. **Modifier les Variables d'Environnement**

    Modifiez les variables d'environnement selon vos besoins. Les variables importantes incluent :

   - `VIRTUAL_HOST`: Le nom de domaine pour accéder à votre site Drupal.
   - `DRUPAL_DB_NAME`, `DRUPAL_DB_USER`, `DRUPAL_DB_PASSWORD`: Les informations de connexion à la base de données.

3. **Installer les Dépendances Composer**

   Assurez-vous que Composer est installé dans votre environnement Docker. Ensuite, exécutez la commande suivante pour installer les dépendances de Drupal :

   ```
   $ cd ./app/drupal
   $ composer install
   ```

4. **Lancer les Conteneurs Docker**

   Lancez les services définis dans le fichier `compose.yaml` :

   ```bash
   $ docker compose up -d
   ```

   Cette commande démarre les conteneurs en arrière-plan. Vous pouvez vérifier les logs avec :

   ```bash
   $ docker compose logs -f
   ```

5. **Accéder à Drupal**

   Une fois les conteneurs en cours d'exécution, vous pouvez accéder à votre site Drupal via votre navigateur à l'adresse définie dans `VIRTUAL_HOST`. Assurez-vous que le nom de domaine est correctement configuré dans votre fichier `/etc/hosts` si vous utilisez un domaine personnalisé localement.

## Structure du Projet

- `compose.yaml`: Fichier de configuration Docker Compose définissant les services (Drupal, MySQL).
- `Dockerfile`: Définition de l'image Docker pour Drupal avec PHP 8.3.
- `.env`: Fichier de configuration pour les variables d'environnement.
- `./app/drupal`: Répertoire contenant les fichiers Drupal.
- `./ssl`: Répertoire contenant les certificats SSL.
- `./db/db-password.txt`: Fichier contenant le mot de passe pour la base de données.

## Arrêter les Conteneurs

Pour arrêter les conteneurs Docker, exécutez :

```bash
$ docker compose down
```

## Notes

- Assurez-vous que les ports 80 et 443 ne sont pas déjà utilisés sur votre machine pour éviter les conflits.
- Le volume `drupal_files` est utilisé pour persister les fichiers téléchargés et les fichiers temporaires de Drupal.

Pour toute question ou problème, veuillez consulter la documentation Docker et Drupal.

---

Bon développement avec Drupal et Docker !
