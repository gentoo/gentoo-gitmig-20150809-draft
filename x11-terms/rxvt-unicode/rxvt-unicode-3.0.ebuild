# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/rxvt-unicode/rxvt-unicode-3.0.ebuild,v 1.13 2006/02/21 11:03:20 s4t4n Exp $

DESCRIPTION="rxvt clone with XFT and Unicode support"
HOMEPAGE="http://software.schmorp.de/"
SRC_URI="http://rxvt-unicode-dist.plan9.de/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc amd64 ppc ppc64"
IUSE="xgetdefault"

DEPEND="dev-util/pkgconfig
	sys-devel/libtool
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
	)"

src_compile() {

	local term
	if [ -n "${RXVT_TERM}" ] ; then
		term="${RXVT_TERM}"
	else
		term="rxvt"
	fi

	econf \
		--enable-everything \
		--enable-rxvt-scroll \
		--enable-next-scroll \
		--enable-xterm-scroll \
		--enable-transparency \
		--enable-xpm-background \
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
		--with-term=${term} \
		--with-term=rxvt \
		`use_enable xgetdefault` \
		--disable-menubar || die

	emake || die
}

src_install() {

	einstall mandir=${D}/usr/share/man/man1 || die

	dodoc README.unicode Changes
	cd ${S}/doc
	dodoc README* changes.txt FAQ BUGS TODO etc/*
}

pkg_postinst() {

	einfo
	einfo "If you want to change default TERM variable other than rxvt,"
	einfo "set RXVT_TERM environment variable and then emerge rxvt-unicode."
	einfo "Especially, if you use rxvt under monochrome X you might need to run"
	einfo "\t RXVT_TERM=rxvt-basic emerge rxvt-unicode"
	einfo "otherwise curses based program will not work."
	ewarn
	ewarn "${PN} has renamed its binaries to urxvt, urxvtd, and urxvtc!"
	ewarn
}
