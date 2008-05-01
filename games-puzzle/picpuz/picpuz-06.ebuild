# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/picpuz/picpuz-06.ebuild,v 1.2 2008/05/01 11:01:43 nyhm Exp $

inherit eutils games

DESCRIPTION="a jigsaw puzzle program"
HOMEPAGE="http://kornelix.squarespace.com/picpuz/"
SRC_URI="http://kornelix.squarespace.com/storage/picpuz/${PN}.${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.8"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc43.patch
	sed -i \
		-e 's:-O3:${CXXFLAGS} ${LDFLAGS}:' \
		picpuz-build.sh \
		|| die "sed failed"
	sed -i \
		-e "s:helppath);:\"/usr/share/doc/${PF}\");:" \
		picpuz.cpp \
		|| die "sed failed"
}

src_compile() {
	./picpuz-build.sh || die "build failed"
}

src_install() {
	newgamesbin ${PN}.x ${PN} || die "newgamesbin failed"
	newicon ${PN}-icon.png ${PN}.png
	make_desktop_entry ${PN} Picpuz
	insinto /usr/share/doc/${PF}
	doins ${PN}-guide.pdf || die "doins failed"
	prepgamesdirs
}
