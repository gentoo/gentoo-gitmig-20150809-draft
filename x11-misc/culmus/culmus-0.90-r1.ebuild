# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/culmus/culmus-0.90-r1.ebuild,v 1.3 2004/01/29 23:04:11 mksoft Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Hebrew Type1 fonts"
SRC_URI="mirror://gentoo/culmus/${P}-1.tar.gz"
HOMEPAGE="http://culmus.sourceforge.net/"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2 | LICENSE-BITSTREAM"

src_install () {
	dodir /usr/X11R6/lib/X11/fonts/culmus
	cp -a * ${D}/usr/X11R6/lib/X11/fonts/culmus
	rm ${D}/usr/X11R6/lib/X11/fonts/culmus/{CHANGES,LICENSE,LICENSE-BITSTREAM,GNU-GPL,culmus.spec}
	dodoc CHANGES LICENSE LICENSE-BITSTREAM
}

pkg_postinst() {
	einfo "Please add /usr/X11R6/lib/X11/fonts/culmus to your FontPath"
	einfo "in XF86Config to make the fonts available to all X11 apps and"
	einfo "not just those that use fontconfig (the latter category includes"
	einfo "kde 3.1 and gnome 2.2)."
	einfo "If you have fontconfig installed, run fc-cache (preferably both"
	einfo "as user and as root) to let it know about these new fonts."
}
