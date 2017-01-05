### Accounts and Groups
Create the following accounts and user groups on your system
Write down the GID and UID of the users and groups. They will be needed for the docker compose file.
* group: media
* user: flexget
* user: plex
* user: sonarr
* user: qbittorrent

### PlexPass Setup
* if you do not have PlexPass remove `&X-Plex-Token=YOUR_PLEX_TOKEN` from the URL in the Plex Dockerfile

### Docker Compose
* edit docker-compose.yml file and point the volumes to your file locations
* edit docker-compose.yml and change the MGUID to your media group GID and update the respective UIDs for each account
* run `docker-compose -d up`
