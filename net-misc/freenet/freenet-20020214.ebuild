# Copyright (c) 2002, Per Wigren <wigren@home.se>
# Maintainer: System Team <system@gentoo.org>
# Author: Per Wigren <wigren@home.se>
# $Header: /var/cvsroot/gentoo-x86/net-misc/freenet/freenet-20020214.ebuild,v 1.1 2002/02/18 21:20:55 karltk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Freenet server"
SRC_URI="http://freenetproject.org/snapshots/freenet-20020214.tgz"
HOMEPAGE="http://freenetproject.org"
DEPEND="virtual/jdk"

src_compile () {
    cd ${S}
    # Set storeSize to a 3rd of the available space on /var
    VARSZ=$(df -m /var|tail -n1|awk '{print $4}')
    if [ $VARSZ -gt 2048 ]; then
        STORSZ=1073741824
    else
        let STORSZ=($VARSZ/3)*1024*1024
    fi

    # Create a default freenet.conf
    (  echo ipAddress=$(hostname)
       echo listenPort=$(let PORT=($RANDOM%30000)+9000; echo $PORT)
       echo seedFile=/var/freenet/seednodes.ref
       echo storeFile=/var/freenet/store
       echo storeSize=$STORSZ
       echo nodeFile=/var/freenet/node
       echo diagnosticsPath=/var/freenet/stats
       echo logLevel=normal
       echo logFile=/var/log/freenet.log
       echo maxHopsToLive=25
       echo fproxy.class=freenet.client.http.FproxyServlet
       echo fproxy.port=8888
       echo fproxy.insertHtl=25
       echo fproxy.requestHtl=25
       echo fproxy.params.filter=false
       echo nodestatus.class=freenet.client.http.NodeStatusServlet
       echo nodestatus.port=8889
       echo logInboundContacts=true
       echo logOutboundContacts=true
       echo logInboundRequests=true
    ) >freenet.conf
}

src_install () {

	dodir /var/freenet/stats

	insinto /usr/lib/freenet 
	doins lib/freenet.jar lib/freenet-ext.jar

	insinto /etc
	doins freenet.conf
	
	exeinto /etc/init.d 
	doexe ${FILESDIR}/freenet

	dosbin ${FILESDIR}/update-freenet
}

