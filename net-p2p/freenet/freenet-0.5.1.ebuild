# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/freenet/freenet-0.5.1.ebuild,v 1.1 2003/04/19 00:32:14 blauwers Exp $

DESCRIPTION="large-scale peer-to-peer network that creates a massive virtual information store open to anyone"
SRC_URI="mirror://sourceforge/freenet/${P}.tar.gz"
HOMEPAGE="http://freenetproject.org/"
DEPEND="virtual/jdk"
SLOT="0"
KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2"
S=${WORKDIR}/${PN}

src_compile() {
	# Set storeSize to a 3rd of the available space on /var
	# but not bigger that 2GB.
	VARSZ=$(df -mP /var|tail -n1|awk '{print $4}')
	if [ $VARSZ -gt 4096 ]; then
		STORSZ=2147483648
	else
		let STORSZ=($VARSZ/3)*1024*1024
	fi

	# Create a default freenet.conf
	(	echo ipAddress=$(hostname)
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

src_install() {
	dodoc README

        dodir /var/freenet/stats

        insinto /usr/lib/freenet
        doins freenet.jar freenet-ext.jar

        insinto /etc
        doins freenet.conf

        exeinto /etc/init.d
        doexe ${FILESDIR}/freenet
}

pkg_postinstall () {
        einfo "Please change /etc/freenet.conf according to your needs!"
}

pkg_postrm() {
        einfo "Please remove /var/freenet manually if you are't going to"
        einfo "continue to use Freenet on this machine!"
}
