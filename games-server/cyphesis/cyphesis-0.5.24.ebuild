# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/cyphesis/cyphesis-0.5.24.ebuild,v 1.1 2010/08/31 06:45:38 mr_bones_ Exp $

EAPI=2
PYTHON_DEPEND=2
inherit autotools python eutils games

DESCRIPTION="WorldForge server running small games"
HOMEPAGE="http://worldforge.org/dev/eng/servers/cyphesis"
SRC_URI="mirror://sourceforge/worldforge/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-libs/skstream-0.3.6
	>=dev-games/wfmath-0.3.9
	=dev-games/mercator-0.2*
	dev-libs/libgcrypt
	dev-libs/libsigc++:2
	sys-libs/ncurses
	sys-libs/readline
	=media-libs/atlas-c++-0.6*
	>=media-libs/varconf-0.6.4
	dev-db/postgresql-base"
DEPEND="${RDEPEND}
	dev-libs/libxml2
	dev-util/pkgconfig"

pkg_setup() {
	python_set_active_version 2
	games_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch \
		"${FILESDIR}"/${P}-gcc45.patch \
		"${FILESDIR}"/${P}-python27.patch
	eautoreconf
}

src_configure() {
	egamesconf \
		--localstatedir=/var
}

src_install() {
	emake DESTDIR="${D}" confbackupdir="/usr/share/doc/${PF}/conf" \
		install || die "emake install failed"
	dodoc AUTHORS ChangeLog FIXME NEWS README THANKS TODO
	prepgamesdirs
}
