# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/jwm/jwm-1.7.ebuild,v 1.7 2009/01/09 15:11:33 remi Exp $

inherit autotools eutils

IUSE="bidi debug png truetype xinerama xpm"

DESCRIPTION="Very fast and lightweight still powerfull window manager for X"
SRC_URI="http://joewing.net/programs/jwm/${P}.tar.bz2"
HOMEPAGE="http://joewing.net/programs/jwm/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~hppa ppc x86"

RDEPEND="xpm? ( x11-libs/libXpm )
	xinerama? ( x11-libs/libXinerama )
	x11-libs/libXext
	x11-libs/libXrender
	x11-libs/libXau
	x11-libs/libXdmcp
	truetype? ( x11-libs/libXft )
	png? ( media-libs/libpng )
	bidi? ( dev-libs/fribidi )
	dev-libs/expat"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xextproto
	xinerama? ( x11-proto/xineramaproto )"

src_compile() {
	econf \
		$(use_enable debug) \
		$(use_enable png) \
		$(use_enable truetype xft) \
		$(use_enable xinerama) \
		$(use_enable xpm) \
		$(use_enable bidi fribidi) \
		--enable-shape --enable-xrender || die "configure failed"

	emake -j1 || die "make failed"
}

src_install() {
	dodir /usr/bin
	dodir /etc
	dodir /usr/share/man
	make BINDIR="${D}/usr/bin" SYSCONF="${D}/etc" \
		MANDIR="${D}/usr/share/man" install || die "make install failed"
	rm "${D}/etc/system.jwmrc"

	echo "#!/bin/sh" > jwm
	echo "exec /usr/bin/jwm" >> jwm
	exeinto /etc/X11/Sessions
	doexe jwm

	dodoc README example.jwmrc todo.txt
}

pkg_postrm() {
	einfo "Put an appropriate configuration file in /etc/system.jwmrc"
	einfo "or in ~/.jwmrc."
	einfo "An example file can be found in ${R}/usr/share/doc/${P}/"
}
