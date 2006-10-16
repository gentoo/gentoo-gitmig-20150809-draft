# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/ggz-gtk-games/ggz-gtk-games-0.0.13.ebuild,v 1.4 2006/10/16 18:59:19 nyhm Exp $

inherit games

DESCRIPTION="These are the GTK+ versions of the games made by GGZ Gaming Zone"
HOMEPAGE="http://www.ggzgamingzone.org/"
SRC_URI="http://ftp.belnet.be/packages/ggzgamingzone/ggz/${PV}/${P}.tar.gz
	http://mirrors.ibiblio.org/pub/mirrors/ggzgamingzone/ggz/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-amd64 ppc x86"
IUSE="nls"
RESTRICT="userpriv"

RDEPEND="~games-board/ggz-gtk-client-${PV}
	=x11-libs/gtk+-2*
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i 's:$[{(]prefix[)}]/share/locale:/usr/share/locale:' \
		$(find po -name 'Makefile.in*') \
		configure \
		|| die "sed failed"
}

src_compile() {
	egamesconf \
		--disable-debug \
		--disable-dependency-tracking \
		$(use_enable nls) \
		|| die
	emake || die "emake failed"
}

src_install() {
	if [[ -f "${ROOT}/${GAMES_SYSCONFDIR}"/ggz/ggz.modules ]] ; then
		dodir "${GAMES_SYSCONFDIR}"/ggz
		cp {"${ROOT}","${D}"}/"${GAMES_SYSCONFDIR}"/ggz/ggz.modules
	fi
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS QuickStart.GGZ README* TODO
	prepgamesdirs
}
