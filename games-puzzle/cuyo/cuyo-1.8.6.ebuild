# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/cuyo/cuyo-1.8.6.ebuild,v 1.2 2007/12/11 22:17:12 tupone Exp $

inherit toolchain-funcs eutils qt3 games

DESCRIPTION="highly addictive and remotely related to tetris"
HOMEPAGE="http://www.karimmi.de/cuyo/"
SRC_URI="http://savannah.nongnu.org/download/cuyo/${P//_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="$(qt_min_version 3.3)"

S=${WORKDIR}/${P/_}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/^gamesdir.*=/ s:\$(prefix)/games:$(bindir):' \
		-e 's:-O2:@CXXFLAGS@ -Wno-long-long:' src/Makefile.in \
		|| die "sed src/Makefile.in failed"
	epatch "${FILESDIR}"/${P}-gcc4.patch
}

src_compile() {
	egamesconf \
		--with-qtdir="${QTDIR}" \
		--with-x \
		|| die
	emake CXX=$(tc-getCXX) MOC="${QTDIR}"/bin/moc || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS NEWS README TODO ChangeLog
	prepgamesdirs
}
