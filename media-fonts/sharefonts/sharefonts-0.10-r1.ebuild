# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/sharefonts/sharefonts-0.10-r1.ebuild,v 1.2 2003/10/10 12:09:16 leonardop Exp $

S=${WORKDIR}/sharefont
DESCRIPTION="A Collection of True Type Fonts"
SRC_URI="mirror://gimp/fonts/${P}.tar.gz"
HOMEPAGE="http://www.gimp.org/fonts.html"
KEYWORDS="x86 sparc ppc"
SLOT="0"
LICENSE="public-domain"

src_install () {

	dodir /usr/X11R6/lib/X11/fonts/sharefont
	cp -a * ${D}/usr/X11R6/lib/X11/fonts/sharefont
	rm  ${D}/usr/X11R6/lib/X11/fonts/sharefont/README
	dodoc README

}

