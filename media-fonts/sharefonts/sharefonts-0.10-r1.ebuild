# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/sharefonts/sharefonts-0.10-r1.ebuild,v 1.1 2003/06/02 13:59:27 seemant Exp $

S=${WORKDIR}/sharefont
DESCRIPTION="A Collection of True Type Fonts"
SRC_URI="ftp://ftp.gimp.org/pub/gimp/fonts/${P}.tar.gz"
HOMEPAGE="http://www.gimp.org/fonts.html"
KEYWORDS="x86 sparc  ppc"
SLOT="0"
LICENSE="public-domain"

src_install () {

	dodir /usr/X11R6/lib/X11/fonts/sharefont
	cp -a * ${D}/usr/X11R6/lib/X11/fonts/sharefont
	rm  ${D}/usr/X11R6/lib/X11/fonts/sharefont/README
	dodoc README

}

