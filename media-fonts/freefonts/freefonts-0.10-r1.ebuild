# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/freefonts/freefonts-0.10-r1.ebuild,v 1.3 2004/05/15 11:02:27 usata Exp $

S=${WORKDIR}/freefont
DESCRIPTION="A Collection of Free Type1 Fonts"
SRC_URI="mirror://gimp/fonts/${P}.tar.gz"
HOMEPAGE="http://www.gimp.org/"
KEYWORDS="x86 sparc ppc"
SLOT="0"
LICENSE="freedist"

src_install () {

	dodir /usr/X11R6/lib/X11/fonts/freefont
	cp -a * ${D}/usr/X11R6/lib/X11/fonts/freefont
	rm  ${D}/usr/X11R6/lib/X11/fonts/freefont/README
	dodoc README

}
