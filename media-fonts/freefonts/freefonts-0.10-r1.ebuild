# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/freefonts/freefonts-0.10-r1.ebuild,v 1.5 2004/07/14 17:05:36 agriffis Exp $

S=${WORKDIR}/freefont
DESCRIPTION="A Collection of Free Type1 Fonts"
SRC_URI="mirror://gimp/fonts/${P}.tar.gz"
HOMEPAGE="http://www.gimp.org/"
KEYWORDS="x86 sparc ppc"
IUSE=""
SLOT="0"
LICENSE="freedist"

src_install () {

	dodir /usr/X11R6/lib/X11/fonts/freefont
	cp -a * ${D}/usr/X11R6/lib/X11/fonts/freefont
	rm  ${D}/usr/X11R6/lib/X11/fonts/freefont/README
	dodoc README

}
