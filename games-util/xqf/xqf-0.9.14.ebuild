# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/xqf/xqf-0.9.14.ebuild,v 1.2 2004/04/12 01:43:01 mr_bones_ Exp $

DESCRIPTION="A server browser for many FPS games (frontend for qstat)"
HOMEPAGE="http://www.linuxgames.com/xqf/"
SRC_URI="mirror://sourceforge/xqf/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc hppa amd64"
IUSE="nls geoip gtk gtk2"

RDEPEND="virtual/glibc
	gtk? (
		gtk2? ( =x11-libs/gtk+-2* )
		!gtk2? (
			=x11-libs/gtk+-1*
			media-libs/gdk-pixbuf
		)
	)
	nls? ( sys-devel/gettext )
	geoip? ( dev-libs/geoip )
	app-arch/bzip2"
DEPEND="${RDEPEND}
	sys-devel/libtool"
RDEPEND="${RDEPEND}
	>=games-util/qstat-25"

src_compile() {
	econf \
		--disable-dependency-tracking \
		`use_enable gtk2` \
		`use_enable nls` \
		`use_enable geoip` \
		--enable-bzip2 \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS BUGS ChangeLog NEWS README TODO
}
