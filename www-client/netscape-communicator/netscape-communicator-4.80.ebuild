# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/netscape-communicator/netscape-communicator-4.80.ebuild,v 1.2 2005/03/15 20:09:45 seemant Exp $

IUSE=""

MY_PV="v${PV//[0.]/}"
MY_P="${PN/netscape-/}-${MY_PV}-us.x86-unknown-linux2.2"
S=${WORKDIR}/${MY_P/-us/}

DESCRIPTION="Netscape Communicator 4.8"
SRC_URI="ftp://ftp.netscape.com/pub/communicator/english/${PV%0}/unix/supported/linux22/complete_install/${MY_P}.tar.gz"
HOMEPAGE="http://developer.netscape.com/support/index.html"

SLOT="0"
KEYWORDS="~x86 -*"
LICENSE="NETSCAPE"

DEPEND="virtual/libc"
RDEPEND=">=sys-libs/lib-compat-1.0
	!www-client/netscape-navigator"

src_install() {
	dodir /opt/netscape
	dodir /usr/X11R6/bin
	dodoc README.install

	cd ${D}/opt/netscape
	tar xz --no-same-owner -f ${S}/netscape-${MY_PV}.nif
	tar xz --no-same-owner -f ${S}/nethelp-${MY_PV}.nif
	tar xz --no-same-owner -f ${S}/spellchk-${MY_PV}.nif

	insinto /opt/netscape/java/classes
	doins ${S}/*.jar

	rm ${D}/opt/netscape/netscape-dynMotif
	rm ${D}/opt/netscape/libnullplugin-dynMotif.so

	# if flashplayer.xpt is installed assume a newer flash plugin exists and remove the Netscape bundled plugin
	if [ -e ${ROOT}/opt/netscape/plugins/flashplayer.xpt ]
	then
		rm ${D}/opt/netscape/plugins/libflashplayer.so
		rm ${D}/opt/netscape/plugins/ShockwaveFlash.class
	fi

	exeinto /usr/X11R6/bin
	doexe ${FILESDIR}/netscape
}
