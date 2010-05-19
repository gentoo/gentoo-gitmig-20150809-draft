# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/cyphesis/cyphesis-0.5.22.ebuild,v 1.2 2010/05/19 14:40:56 tupone Exp $

EAPI=2
inherit autotools eutils games

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
	virtual/postgresql-base"
DEPEND="${RDEPEND}
	dev-libs/libxml2
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch \
		"${FILESDIR}"/${P}-gcc45.patch
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
