# /etc/conf.d/squeezecenter

# Niceness level for the SqueezeCenter process. If not specified then the
# default is to run at standard priority. Uncomment the following to run at a
# high priority (in order to try to minimise drop-outs due to audio starvation
# of the players):
#SC_NICENESS=-10

# Default path of your music library and playlists. You can leave these
# undefined and configure them through the web interface instead.
#SC_MUSIC_DIR=/mnt/media/Music
#SC_PLAYLISTS_DIR=/mnt/media/Playlists

# The following contains any other options you want to specify, such as default
# logging options. The example below will prevent the discovery and display of
# UPNP devices within your players.
#
# See "squeezecenter.pl --help" for a full list of possible options, but note
# that many of them are supplied by /etc/init.d/squeezecenter and so don't need
# to be present here.
#SC_OPTS="--noupnp"
