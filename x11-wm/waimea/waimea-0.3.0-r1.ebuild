# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Spider <spider@gentoo.org>
# Maintainer: Spider <spider@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-wm/waimea/waimea-0.3.0-r1.ebuild,v 1.1 2002/05/09 15:21:59 spider Exp $
 
S=${WORKDIR}/${P}
DESCRIPTION="Window manager based on BlackBox"
SRC_URI="http://download.sourceforge.net/${PN}/${P}.tar.gz"
HOMEPAGE="http://waimea.sf.net"
LICENSE="GPL-2"

DEPEND="virtual/x11"
	
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
	
	dodir /etc/skel/.waimearc
	insinto /etc/skel/.waimearc
	doins data/menu

	dodir /etc/skel/.waimearc/styles
	insinto /etc/skel/.waimearc/styles
	doins data/styles/Default
	
	dodir /etc/skel/.waimearc/actions
	insinto /etc/skel/.waimearc/actions
	doins data/actions/action.*
	dosym /etc/skel/.waimearc/actions/action /etc/skel/.waimearc/actions/action.sloppy-focus
	
	dodoc ChangeLog AUTHORS COPYING INSTALL README TODO NEWS

	dodir /etc/X11/Sessions
	echo "/usr/bin/waimea" > ${D}/etc/X11/Sessions/waimea
	chmod +x ${D}/etc/X11/Sessions/waimea
}
pkg_postinst () {
	einfo "copy /etc/skel/.waimearc to your homedir (cp -a /etc/skel/.waimearc $HOME)"
}
