#  here is where to define which server start.
#> Additional parameters to be passed to mysqld at startup may be added here,
#> these one will override the ones in "my.cnf".
#
#  Below are described some suggested parameters to use
#  The parameters not recognized will be passed through to the mysqld daemon
#
#  Parameter      : description
# ----------------+-----------------------------------------------------------
# nice            : integer [-20 .. 19 ] default 0
#                 : change the priority of the server -20 (high) to 19 (low)
#                 : see "man nice 1" for description
# ----------------+-----------------------------------------------------------
# mycnf           : string [full path to my.cnf]
#                 : specify the path to my.cnf file to be used
# ----------------+-----------------------------------------------------------
# TODO chroot     : string [path to chroot directory]
#                 : Tell the script that the server will be run in a chrooted
#                 : environment.
#                 : You may want to "mount -obind" a shared directory for the
#                 : socket (usually /var/lib/run) or to instruct every client
#                 : that connect to localhost (thus using sock connection)
#                 : (will NOT be passed to the MySQL server)
# ----------------+-----------------------------------------------------------
#
#  Additional parameters
#  Parameter      : description
# ----------------+-----------------------------------------------------------
# server-id       : integer [1 .. 255]
#                 : Uniquely identifies the server instance in the community
#                 : of replication partners.
# ----------------+-----------------------------------------------------------
# port            : integer [1025 .. 65535] default 3306
#                 : Port number to use for connection.
#                 : loose any meaning if skip-networking is set.
# ----------------+-----------------------------------------------------------
# skip-networking : NULL, Don't allow connection with TCP/IP.
# log-bin         : string [name of the binlog files]
#                 : Log update queries in binary format. Optional (but
#                 : strongly recommended to avoid replication problems if
#                 : server's hostname changes) argument should be the chosen
#                 : location for the binary log files.
# ----------------+-----------------------------------------------------------
#
# start a default server with default options:
# need symlinks (try emerge --config =dev-db/mysql-[version])
#
#mysql_slot_0=()
#
# start MySQL 7.5.x reniced, chrooted and overriding some start parameters
#
#mysql_slot_705=(
#	"nice=-5"
#	"chroot=/chroot/mysql-705"
#   "server-id=123"
#   "log-bin="myhost"
#   "port=3307"
#)
# start another server, same version, different my.cnf
#
#mysql_slot_705_1=(
#	"mycnf=/home/test/my.cnf"
#   "server-id=124"
#)
#  To avoid starting a server just comment it's definition
#  To avoid confusion mysql init script MUST found at least one definition
#> here or it will rant (no default start)
#  Last but not least, spaces are NOT allowed inside the parameters

