# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-www/netscape-communicator/netscape-communicator-4.79.ebuild,v 1.4 2002/07/14 20:25:23 aliz Exp $

S=${WORKDIR}/communicator-v479.x86-unknown-linux2.2
DESCRIPTION="Netscape Communicator 4.79"
SRC_URI="ftp://ftp.netscape.com/pub/communicator/english/4.79/unix/supported/linux22/complete_install/communicator-v479-us.x86-unknown-linux2.2.tar.gz"
HOMEPAGE="http://developer.netscape.com/support/index.html"
RDEPEND=">=sys-libs/lib-compat-1.0"
SLOT="0"
KEYWORDS="x86"

src_install() {								  
	cd ${S}
	dodir /opt/netscape
	dodir /opt/netscape/java/classes
	dodir /usr/X11R6/bin
	dodoc README.install
	cd ${D}/opt/netscape
	gzip -dc ${S}/netscape-v479.nif | tar xf -
	gzip -dc ${S}/nethelp-v479.nif | tar xf -
	gzip -dc ${S}/spellchk-v479.nif | tar xf -
	cp ${S}/*.jar ${D}/opt/netscape/java/classes
	cp ${FILESDIR}/netscape ${D}/usr/X11R6/bin/netscape
	rm ${D}/opt/netscape/netscape-dynMotif
	rm ${D}/opt/netscape/libnullplugin-dynMotif.so
	insinto /usr/X11R6/bin
	doins ${FILESDIR}/netscape 
	chmod +x ${D}/usr/X11R6/bin/netscape
}

