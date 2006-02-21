# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/rxvt-unicode/rxvt-unicode-4.0.ebuild,v 1.11 2006/02/21 11:03:20 s4t4n Exp $

inherit eutils 64-bit

DESCRIPTION="rxvt clone with XFT and Unicode support"
HOMEPAGE="http://software.schmorp.de/"
SRC_URI="http://rxvt-unicode-dist.plan9.de/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ~mips amd64 ~ppc ~hppa ppc64"
IUSE="xgetdefault"

DEPEND="dev-util/pkgconfig
	sys-devel/libtool
	|| (
		(
			x11-libs/libX11
			x11-libs/libXft
			x11-libs/libXpm
			x11-libs/libXrender
			x11-proto/xproto
			x11-libs/libXt
		)
		virtual/x11
	)
	dev-lang/perl"

src_unpack() {
	unpack ${A}
	cd ${S}
	local tdir=/usr/share/terminfo
	sed -i -e \
		"s~@TIC@ \(etc/rxvt\)~@TIC@ -o ${D}/${tdir} \1~" \
		doc/Makefile.in
	64-bit && epatch ${FILESDIR}/${P}-64bit.patch
}

src_compile() {
	econf \
		--enable-everything \
		--enable-rxvt-scroll \
		--enable-next-scroll \
		--enable-xterm-scroll \
		--enable-transparency \
		--enable-xpm-background \
		--enable-fading \
		--enable-utmp \
		--enable-wtmp \
		--enable-mousewheel \
		--enable-slipwheeling \
		--enable-smart-resize \
		--enable-ttygid \
		--enable-256-color \
		--enable-xim \
		--enable-shared \
		--enable-keepscrolling \
		--enable-xft \
		`use_enable xgetdefault` \
		--disable-text-blink \
		--disable-menubar || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc README.unicode Changes
	cd ${S}/doc
	dodoc README* changes.txt BUGS TODO etc/*
}

pkg_postinst() {
	einfo "urxvt now always uses TERM=rxvt-unicode so that the"
	einfo "upstream-supplied terminfo files can be used."
}
