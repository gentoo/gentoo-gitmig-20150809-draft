# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/groundhog/groundhog-1.4.ebuild,v 1.20 2008/05/15 13:32:31 nyhm Exp $

inherit eutils autotools games

DEB_VER="9"
DESCRIPTION="Put the balls in the pockets of the same color by manipulating a maze of tubes"
HOMEPAGE="http://home-2.consunet.nl/~cb007736/groundhog.html"
SRC_URI="http://home-2.consunet.nl/~cb007736/${P}.tar.gz
	mirror://debian/pool/main/g/groundhog/groundhog_${PV}-${DEB_VER}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="nls"

RDEPEND="=x11-libs/gtk+-2*
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	epatch "${WORKDIR}"/groundhog_${PV}-${DEB_VER}.diff
	cd "${S}"
	epatch $(sed -e 's:^:debian/patches/:' debian/patches/series)
	AT_M4DIR="m4" eautoreconf
	sed -i 's:$(localedir):/usr/share/locale:' \
		$(find . -name 'Makefile.in*') \
		|| die "sed failed"
}

src_compile() {
	egamesconf $(use_enable nls) || die
	emake CXXFLAGS="${CXXFLAGS}" || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README NEWS AUTHORS TODO
	prepgamesdirs
}
