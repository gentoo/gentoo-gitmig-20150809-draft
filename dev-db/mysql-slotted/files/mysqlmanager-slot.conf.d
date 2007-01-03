#  here is where to define which server start.
#> Additional parameters to be passed to mysqlmanager at startup may be added here,
#> these one will override the ones in "my.cnf".
#
#  To avoid starting a server just comment it's definition
#> here or it will rant (no default start)
#  Last but not least, spaces are NOT allowed inside the parameters
#
#  Below are described some suggested parameters to use
#  The parameters not recognized will be passed through to the mysqlmanager
#
#  Parameter      : description

# ----------------+-----------------------------------------------------------
# mycnf           : string [full path to my.cnf]
#                 : specify the path to my.cnf file to be used
#                 : may contain a [manager] section
# ----------------+-----------------------------------------------------------
#
# easy default
#
#mysqlmanager_slot_0=()
#
# start MySQL 7.5.x reniced, chrooted and overriding some start parameters
#mysqlmanager_slot_7_0_5=(
#	"mycnf=/home/test/my.cnf"
#)
#
