# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/sharefonts/sharefonts-0.10-r1.ebuild,v 1.8 2008/02/03 19:54:49 dirtyepic Exp $

S=${WORKDIR}/sharefont
DESCRIPTION="A Collection of Postscript Type1 Fonts"
SRC_URI="mirror://gimp/fonts/${P}.tar.gz"
HOMEPAGE="http://www.gimp.org/fonts.html"

IUSE=""
KEYWORDS="x86 sparc ppc amd64"
SLOT="0"
LICENSE="public-domain"

src_install () {

	dodir /usr/X11R6/lib/X11/fonts/sharefont
	cp -a * "${D}"/usr/X11R6/lib/X11/fonts/sharefont
	rm  "${D}"/usr/X11R6/lib/X11/fonts/sharefont/README
	dodoc README

}
