# $Header:
/home/cvsroot/gentoo-x86/app-sci/zetagrid/zetagrid-1.0-r5.ebuild,v 1.1
2003/02/25 22:51:26 tantive Exp $

# ======================================================================
#  zeta.sh        Start script for the ZetaGrid client
# ----------------------------------------------------------------------
#
#  This script sets the environment for the ZetaGrid client.
#
#  Please note:
#
#  - You must adopte the Java call below for your environment.
#
#  - If you have to access the Internet through a proxy server
#    you must add -Dhttp.proxyHost=$PROXY_HOST
#    and -Dhttp.proxyPort=$PROXY_PORT in the command below.
#    Example: -Dhttp.proxyHost=proxy.computer.com
#             -Dhttp.proxyPort=80
#
#  Prerequisite: Java Runtime Environment 1.2.2 or higher,
#                e.g. http://java.sun.com/j2se/1.3/download.html
#
# ======================================================================

if [ -n "$http_proxy" ]; then
    http_proxy="${http_proxy#http://}"
    http_proxy="${http_proxy%/}"
    proxies="-Dhttp.proxyHost=${http_proxy%:*} \
             -Dhttp.proxyPort=${http_proxy#*:}"
else
    proxies=""
fi

nohup nice -19 java -Xmx128m $proxies -Djava.library.path=. -Dsun.net.inetaddr.ttl=0 -Dnetworkaddress.cache.ttl=0 -Dnetworkaddress.cache.negative.ttl=0 -cp zeta.jar:zeta_client.jar zeta.ZetaClient &
