# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/waimea/waimea-0.3.5.ebuild,v 1.5 2003/06/22 23:23:50 vapier Exp $
 
DESCRIPTION="Window manager based on BlackBox"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	http://130.239.134.83/waimea/files/unstable/source/${P}.tar.gz"
HOMEPAGE="http://waimea.sf.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"

DEPEND="virtual/x11
	media-libs/imlib2"
PROVIDE="virtual/blackbox"

src_compile() {
	econf || die "configure failure whine whine"
	emake || die "make died, that sux0rs"
}

src_install() {
	einstall sysconfdir=${D}/etc/X11/waimea || die

	dodoc ChangeLog AUTHORS COPYING INSTALL README TODO NEWS

	exeinto /etc/X11/Sessions
	echo "/usr/bin/waimea" > waimea
	doexe waimea
}

pkg_postinst() {
	einfo "unfortunately the older version of this package broke the"
	einfo "/etc/skel/.waimearc and made it a directory, please remove"
	einfo "this if you want the package to install perfectly"
	einfo "copy /etc/skel/.waimearc to your homedir:"
	einfo "  cp -a /etc/skel/.waimearc ${HOME}/"
}
