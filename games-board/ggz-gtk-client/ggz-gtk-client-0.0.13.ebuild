# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/ggz-gtk-client/ggz-gtk-client-0.0.13.ebuild,v 1.6 2006/10/11 15:35:26 nyhm Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"
inherit autotools eutils games

DESCRIPTION="The gtk client for the GGZ Gaming Zone"
HOMEPAGE="http://www.ggzgamingzone.org/"
SRC_URI="http://ftp.belnet.be/packages/ggzgamingzone/ggz/${PV}/${P}.tar.gz
	http://mirrors.ibiblio.org/pub/mirrors/ggzgamingzone/ggz/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-amd64 ppc x86"
IUSE="gaim"
RESTRICT="userpriv"

RDEPEND="~dev-games/ggz-client-libs-${PV}
	=x11-libs/gtk+-2*
	virtual/libintl
	gaim? ( =net-im/gaim-1.5* )"
DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-gaim.patch

	sed -i '/desktopdir/s:$(datadir):/usr/share:' \
		Makefile.am || die "sed Makefile.am failed"

	eautoreconf

	sed -i 's:$(includedir):/usr/include:' \
		ggz-gtk/Makefile.in || die "sed Makefile.in failed"

	sed -i '/locale/s:$(prefix):/usr:' \
		po/Makefile.in || die "sed configure.ac failed"
}

src_compile() {
	egamesconf \
		--disable-debug \
		$(use_enable gaim) \
		|| die
	emake || die "emake failed"
}

src_install() {
	dodir /usr/include
	emake DESTDIR="${D}" install || die "emake install failed"
	rmdir "${D}/${GAMES_PREFIX}"/include

	dodoc AUTHORS ChangeLog NEWS QuickStart.GGZ README* TODO
	prepgamesdirs
}
