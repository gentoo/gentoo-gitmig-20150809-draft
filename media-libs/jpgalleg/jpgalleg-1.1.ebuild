# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/jpgalleg/jpgalleg-1.1.ebuild,v 1.5 2004/03/19 07:56:04 mr_bones_ Exp $

DESCRIPTION="The jpeg loading routines are able to load almost any JPG image file with Allegro."
HOMEPAGE="http://orbflux.com/jpgalleg/"
SRC_URI="http://orbflux.com/jpgalleg/${PN}.zip
	http://www.dribin.org/dave/game_launcher/jpgal11b.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND=">=media-libs/allegro-4.0.0
	>=app-arch/unzip-5.50"
RDEPEND="${DEPEND}"
S="${WORKDIR}"

src_compile() {
	mv jpgal11b.pat jpgal11b.pat_orig
	sed s/'jpgal11\/'/''/ jpgal11b.pat_orig  > jpgal11b.pat
	patch -p0 <jpgal11b.pat
	mv jpeg.c jpeg.c_orig
	sed s/'allegro\/aintern\.h'/'allegro\/internal\/aintern.h'/ jpeg.c_orig > jpeg.c
	emake -f makefile.dj libjpgal.a || die

}

src_install() {
	cd ${S}/
	dodir /usr/include
	dodir /usr/lib

	insinto /usr/include
	doins jpgalleg.h

	insinto /usr/lib
	doins libjpgal.a

	dodoc README

	insinto /usr/share/doc/${P}/examples
	doins *   # maybe not a good idea but it's not really a 'package'
}
