# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# /space/gentoo/cvsroot/gentoo-x86/net-www/netscape/netscape-4.79.ebuild,v 1.1 2001/08/03 13:33:54 pm Exp

S=${WORKDIR}/navigator-v408.x86-unknown-linux2.0
DESCRIPTION="Netscape Communicator 4.08"
SRC_URI="ftp://ftp.netscape.com/pub/communicator/4.08/english/unix/unsupported/linux20_glibc2/complete_install/navigator-standalone/navigator-v408-export.x86-unknown-linux2.0_glibc.tar.gz"
HOMEPAGE="http://developer.netscape.com/support/index.html"
RDEPEND=">=sys-libs/lib-compat-1.0"
PROVIDE="virtual/x11-web-browser"

src_install() {								  
	cd ${S}
	dodir /opt/netscape
	dodir /opt/netscape/java/classes
	dodir /usr/X11R6/bin
	dodoc README.install
	cd ${D}/opt/netscape
	gzip -dc ${S}/netscape-v408.nif | tar xf -
	gzip -dc ${S}/nethelp-v408.nif | tar xf -
#	gzip -dc ${S}/spellchk-v408.nif | tar xf -
	cp ${S}/*.jar ${D}/opt/netscape/java/classes
	cp ${FILESDIR}/netscape ${D}/usr/X11R6/bin/netscape
	rm ${D}/opt/netscape/netscape-dynMotif
	rm ${D}/opt/netscape/libnullplugin-dynMotif.so
	insinto /usr/X11R6/bin
	doins ${FILESDIR}/netscape 
	chmod +x ${D}/usr/X11R6/bin/netscape
}

