# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mamory/mamory-0.2.20.ebuild,v 1.3 2006/07/06 07:54:40 blubb Exp $

inherit games autotools

DESCRIPTION="rom management tools and library"
HOMEPAGE="http://mamory.sourceforge.net/"
SRC_URI="mirror://sourceforge/mamory/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	
	cd ${S}

	# Remove hardcoded CFLAGS options
	sed -i configure.in \
		-e '/AC_ARG_ENABLE(debug,/ {N;N;N;d}'

	# Make it possible for eautoreconf to fix fPIC etc.
	sed -i common/Makefile.am \
		-e '/libcommon_la_LDFLAGS= -static/d'

	AT_M4DIR="config" eautoreconf || die
}	

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--includedir=/usr/include || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README TODO
	dohtml DOCS/mamory.html
	prepgamesdirs
}
