# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/ggz-kde-client/ggz-kde-client-0.0.13.ebuild,v 1.1 2006/10/17 00:26:16 nyhm Exp $

inherit eutils kde-functions multilib games

DESCRIPTION="The KDE client for GGZ Gaming Zone"
HOMEPAGE="http://www.ggzgamingzone.org/"
SRC_URI="http://ftp.ggzgamingzone.org/pub/ggz/${PV}/${P}.tar.gz
	http://mirrors.ibiblio.org/pub/mirrors/ggzgamingzone/ggz/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""
RESTRICT="userpriv"

DEPEND="~dev-games/ggz-client-libs-${PV}"

need-kde 3

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i 's:$(prefix)/share:$(datadir):' \
		ggz-kde/ggzcore++/doc/{,html/}Makefile.in \
		|| die "sed failed"
	epatch "${FILESDIR}"/${P}-defines.patch
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--libdir=/usr/$(get_libdir) \
		--datadir=/usr/share \
		--disable-debug \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS *.GGZ README TODO
	prepgamesdirs
}
