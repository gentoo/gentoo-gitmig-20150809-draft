# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/picpuz/picpuz-1.7.ebuild,v 1.1 2008/08/25 22:54:38 mr_bones_ Exp $

inherit toolchain-funcs eutils games

DESCRIPTION="a jigsaw puzzle program"
HOMEPAGE="http://www.kornelix.com/picpuz"
SRC_URI="http://www.kornelix.com/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.8"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e 's/CFLAGS/CXXFLAGS/g' \
		-e '/LFLAGS/s/$/ $(LDFLAGS)/' \
		-e '/^CXXFLAGS/s/=/+=/' \
		-e 's/-O//' \
		-e "s/g++/$(tc-getCXX)/g" \
		Makefile \
		|| die "sed failed"
	rm -f doc/COPYING
	mv doc/*pdf "${T}" || die "mv failed"
}

src_compile() {
	emake \
		BINDIR="${GAMES_BINDIR}" \
		DATADIR="${GAMES_DATADIR}/${PN}" \
		DOCDIR=/usr/share/doc/${PF} \
		|| die "emake failed"
}

src_install() {
	emake \
		DESTDIR="${D}" \
		BINDIR="${GAMES_BINDIR}" \
		DATADIR="${GAMES_DATADIR}/${PN}" \
		DOCDIR=/usr/share/doc/${PF} \
		install \
		|| die "emake failed"
	doicon data/icons/${PN}.png
	make_desktop_entry ${PN} Picpuz
	prepalldocs
	insinto /usr/share/doc/${PF}
	doins "${T}"/*pdf || die "doins failed"
	prepgamesdirs
}
