# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/sharefonts/sharefonts-0.10-r1.ebuild,v 1.6 2004/06/24 22:31:00 agriffis Exp $

S=${WORKDIR}/sharefont
DESCRIPTION="A Collection of True Type Fonts"
SRC_URI="mirror://gimp/fonts/${P}.tar.gz"
HOMEPAGE="http://www.gimp.org/fonts.html"

IUSE=""
KEYWORDS="x86 sparc ppc amd64"
SLOT="0"
LICENSE="public-domain"

src_install () {

	dodir /usr/X11R6/lib/X11/fonts/sharefont
	cp -a * ${D}/usr/X11R6/lib/X11/fonts/sharefont
	rm  ${D}/usr/X11R6/lib/X11/fonts/sharefont/README
	dodoc README

}

