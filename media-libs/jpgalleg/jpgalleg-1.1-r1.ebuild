# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/jpgalleg/jpgalleg-1.1-r1.ebuild,v 1.3 2004/03/19 07:56:04 mr_bones_ Exp $

DESCRIPTION="The jpeg loading routines are able to load almost any JPG image file with Allegro."
HOMEPAGE="http://orbflux.com/jpgalleg/"
SRC_URI="http://orbflux.com/jpgalleg/${PN}.zip
	http://www.dribin.org/dave/game_launcher/jpgal11b.zip"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"
IUSE=""

DEPEND=">=media-libs/allegro-4.0.0
	>=app-arch/unzip-5.50
	>=sys-apps/sed-4"
S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e 's:jpgal11b/::' jpgal11b.pat || \
		die "sed jpgal11b.pat failed"

	edos2unix jpgal11b.pat

	epatch jpgal11b.pat || die

	sed -i \
		-e 's:allegro/aintern.h:allegro/internal/aintern.h:' jpeg.c || \
		die "sed jpeg.c failed"

	sed -i \
		-e "s/-O3/${CFLAGS}/" makefile.dj || \
		die "sed makefile.dj failed"
}

src_compile() {
	emake -f makefile.dj libjpgal.a || die "emake failed"
}

src_install() {
	cd ${S}/

	insinto /usr/include
	doins jpgalleg.h

	insinto /usr/lib
	doins libjpgal.a

	dodoc README

	insinto /usr/share/doc/${P}/examples
	doins *.jpg ex*.c jpeg{data,demo}* makefile*
}
