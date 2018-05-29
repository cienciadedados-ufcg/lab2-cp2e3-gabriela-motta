library(tidyverse)
library(here)
library(spotifyr)

# Você precisará pegar um id e segredo para seu código aqui: https://developer.spotify.com/my-applications/#!/applications 
# 
chaves = read_csv(here::here("code/chaves-do-spotify.csv"), 
                  col_types = "cc")

Sys.setenv(SPOTIFY_CLIENT_ID = pull(chaves, client_id))
Sys.setenv(SPOTIFY_CLIENT_SECRET = pull(chaves, client_secret))

# Autentica com a API e pega token para usar os endpoints 
access_token <- get_spotify_access_token()

# Acessa as músicas de uma playlist específica
playlists <- get_user_playlists('gabimotta15')

tracks <- get_playlist_tracks(playlists) %>%
    filter(playlist_name == "AD1 - Boybands")

playlist_audio_features <- get_track_audio_features(tracks) %>% 
    mutate(track_name = tracks$track_name, album_name = tracks$album_name, artist = tracks$artist_name)

playlist_audio_features %>% 
    write_csv(here::here("data/playlist-boybands.csv"))


tracks2 <- get_playlist_tracks(playlists) %>%
    filter(playlist_name == "AD1 - Lady Gaga")

playlist_audio_features2 <- get_track_audio_features(tracks2) %>% 
    mutate(track_name = tracks2$track_name, album_name = tracks2$album_name, artist = tracks2$artist_name)

playlist_audio_features2 %>% 
    write_csv(here::here("data/playlist_gaga.csv"))

