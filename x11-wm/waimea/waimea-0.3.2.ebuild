# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-wm/waimea/waimea-0.3.2.ebuild,v 1.4 2002/08/14 15:45:39 murphy Exp $
 
S=${WORKDIR}/${P}
DESCRIPTION="Window manager based on BlackBox"
SRC_URI="http://download.sourceforge.net/${PN}/${P}.tar.gz
http://130.239.134.83/waimea/files/unstable/source/${P}.tar.gz"
HOMEPAGE="http://waimea.sf.net"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/x11 media-libs/imlib2"
	
RDEPEND="${DEPEND}"
PROVIDE="virtual/blackbox"

src_compile() {
	local myconf
	econf || die "configure failure whine whine"
	emake || die
}

src_install () {
	make \
		prefix=${D}/usr \
		sysconfdir=${D}/etc/X11/waimea \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		datadir=${D}/usr/share \
		install || die
	
	insinto /etc/skel
	newins data/waimearc.example .waimearc
	
	# just for careful
	insinto /usr/share/Waimea/
	doins data/waimearc.example
	

	dodoc ChangeLog AUTHORS COPYING INSTALL README TODO NEWS

	dodir /etc/X11/Sessions
	echo "/usr/bin/waimea" > ${D}/etc/X11/Sessions/waimea
	chmod +x ${D}/etc/X11/Sessions/waimea
}
pkg_postinst () {
	einfo "unfortunately the older version of this package broke the /etc/skel/.waimearc and made it a directory, please remove this if you want the package to install perfectly"
	einfo "copy /etc/skel/.waimearc to your homedir (cp -a /etc/skel/.waimearc $HOME)"
	
}
