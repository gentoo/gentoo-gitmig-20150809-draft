# Config file for /etc/init.d/tux
# modified from original to be Gentoo like
# $Header: /var/cvsroot/gentoo-x86/net-www/tux/files/tux.conf.d,v 1.1 2003/06/16 19:54:02 vapier Exp $

# TUX_THREADS sets the number of kernel threads (and associated daemon
# threads) that will be used.  $TUX_THREADS defaults to 1.
# TUX_THREADS=1

# DOCROOT is the document root; it works the same way as other web
# servers such as apache.  This must have only 1 trailing /.
TUX_DOCROOT=/home/httpd/htdocs/

# LOGFILE is the file where tux logs information for each
# request. Note that tux writes log files in a binary format and to
# read them you will need to first convert them into standard
# W3C-conforming HTTPD log files using the utility tux2w3c. If no
# LOGFILE is specified then requests will not be logged.
TUX_LOGFILE=/var/log/tux

# TUX_UID and TUX_GID are the user and group as which the daemon runs
# This does not mean that you should execute untrusted modules -- they
# are opened as user/group root, which means that the _init() function,
# if it exists, is run as root.  This feature is only designed to help
# protect from programming mistakes; it is NOT really a security mechanism.
TUX_UID=nobody
TUX_GID=nobody

# CGIs can be started in a chroot environment by default.
# set TUX_CGIROOT=/ if you want CGI programs to have access to the whole system.
TUX_CGIROOT=/home/httpd/htdocs

# each HTTP connection has an individual timer that makes sure
# no connection hangs forever. (due to browser bugs or DoS attacks.)
# TUX_KEEPALIVE=30

# TUX_MODULES is a list of user-space TUX modules.  User-space TUX
# modules are used to serve dynamically-generated data via tux.
# "man 2 tux" for more information
# TUX_MODULES="demo.tux demo2.tux demo3.tux demo4.tux"

# TUX_MODULEPATH is the path to user-space TUXapi modules
# TUX_MODULEPATH="/"
