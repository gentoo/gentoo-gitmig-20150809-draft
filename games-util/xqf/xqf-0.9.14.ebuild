# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/xqf/xqf-0.9.14.ebuild,v 1.7 2004/08/17 01:41:19 vapier Exp $

DESCRIPTION="A server browser for many FPS games (frontend for qstat)"
HOMEPAGE="http://www.linuxgames.com/xqf/"
SRC_URI="mirror://sourceforge/xqf/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc hppa amd64"
IUSE="nls geoip gtk gtk2"

RDEPEND="virtual/libc
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
	>=games-util/qstat-2.5"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# "splash.png" is pretty generic.  (bug #55949)
	sed -i \
		-e 's/splash.png/xqfsplash.png/' \
		src/{splash.c,dialogs.c} pixmaps/Makefile.in \
		|| die "sed failed"
	mv pixmaps/splash.png pixmaps/xqfsplash.png || die "mv failed"
}

src_compile() {
	econf \
		--disable-dependency-tracking \
		$(use_enable gtk2) \
		$(use_enable nls) \
		$(use_enable geoip) \
		--enable-bzip2 \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS BUGS ChangeLog NEWS README TODO
}
