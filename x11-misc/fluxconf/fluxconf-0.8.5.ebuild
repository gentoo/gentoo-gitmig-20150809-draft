# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fluxconf/fluxconf-0.8.5.ebuild,v 1.1 2002/07/15 01:42:13 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Configuration editor for fluxbox"
SRC_URI="http://devaux.fabien.free.fr/flux/${P}.tar.gz"
HOMEPAGE="http://devaux.fabien.free.fr/flux/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="=x11-libs/gtk+-1.2*"

src_compile() {
	
	econf || die
	emake || die
}

src_install () {

	einstall || die
	

	rm ${D}/usr/bin/fluxkeys ${D}/usr/bin/fluxmenu

	dosym /usr/bin/fluxconf /usr/bin/fluxkeys
	dosym /usr/bin/fluxconf /usr/bin/fluxmenu
	
	dodoc AUTHORS COPYING ChangeLog NEWS README
}
