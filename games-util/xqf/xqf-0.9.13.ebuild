# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/xqf/xqf-0.9.13.ebuild,v 1.5 2004/01/28 06:36:17 vapier Exp $

inherit games

DESCRIPTION="A server browser for many FPS games (frontend for qstat)"
HOMEPAGE="http://www.linuxgames.com/xqf/"
SRC_URI="mirror://sourceforge/xqf/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc hppa ~amd64"
IUSE="nls geoip gtk2"

DEPEND=">=games-util/qstat-25
	gtk2? ( =x11-libs/gtk+-2* ) : ( =x11-libs/gtk+-1* media-libs/gdk-pixbuf )
	geoip? ( dev-libs/geoip )
	sys-devel/libtool
	app-arch/bzip2"
RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext )"

src_compile() {
	egamesconf \
		`use_enable gtk2` \
		`use_enable nls` \
		`use_enable geoip` \
		--enable-bzip2 \
		|| die
	emake || die "emake failed"
}

src_install() {
	egamesinstall || die
	dodoc AUTHORS BUGS ChangeLog NEWS README TODO
	prepgamesdirs
}
