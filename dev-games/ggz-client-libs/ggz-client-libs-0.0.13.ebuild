# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/ggz-client-libs/ggz-client-libs-0.0.13.ebuild,v 1.6 2006/10/16 19:05:53 nyhm Exp $

inherit games

DESCRIPTION="The client libraries for GGZ Gaming Zone"
HOMEPAGE="http://www.ggzgamingzone.org/"
SRC_URI="http://ftp.belnet.be/packages/ggzgamingzone/ggz/${PV}/${P}.tar.gz
	http://mirrors.ibiblio.org/pub/mirrors/ggzgamingzone/ggz/${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="-amd64 ppc x86"
IUSE=""

DEPEND="~dev-games/libggz-${PV}
	dev-libs/expat"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i 's:$(prefix)/share/locale:/usr/share/locale:' \
		$(find po -name 'Makefile.in*') \
		|| die "sed failed"

	sed -i '/SUBDIRS/s/desktop//' \
		Makefile.in || die "sed failed"

	sed -i 's:${prefix}/include:/usr/include:' \
		configure || die "sed failed"
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--sysconfdir=${GAMES_SYSCONFDIR}/ggz \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS Quick* README*
	prepgamesdirs
}
