# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/abe/abe-1.0.ebuild,v 1.5 2004/11/08 01:24:29 josejx Exp $

inherit eutils games

MY_P="${P/./_}"
DESCRIPTION="A scrolling, platform-jumping, key-collecting, ancient pyramid exploring game"
HOMEPAGE="http://abe.sourceforge.net"
SRC_URI="mirror://sourceforge/abe/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE=""

RDEPEND=">=media-libs/libsdl-1.2.3
	>=media-libs/sdl-mixer-1.2.5"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S="${WORKDIR}/${MY_P}"
DEST_DIR="${GAMES_DATADIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}/src"

	# Modify paths to resources
	sed -i \
		-e "s:\"images\":\"${DEST_DIR}/images\":" Image.h \
		|| die "sed Image.h failed"
	sed -i \
		-e "s:\"maps\":\"${DEST_DIR}/maps\":" Map.h MapIO.h \
		|| die "sed Map.h MapIO.h failed"
	sed -i \
		-e "s:\"sounds\":\"${DEST_DIR}/sounds\":" Sound.h \
		|| die "sed Sound.h failed"
	epatch "${FILESDIR}/${PV}-gentoo-paths.patch"
}

src_compile() {
	./autogen.sh || die "autogen.sh failed"
	egamesconf || die
	emake || die "emake failed"
}

src_install() {
	dogamesbin abe || die "dogamesbin failed"
	dodir "${DEST_DIR}"
	cp -R images sounds maps "${D}${DEST_DIR}" || die "cp failed"
	dodoc README
	prepgamesdirs
}
