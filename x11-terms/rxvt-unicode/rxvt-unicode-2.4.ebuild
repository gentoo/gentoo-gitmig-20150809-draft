# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/rxvt-unicode/rxvt-unicode-2.4.ebuild,v 1.1 2004/03/21 16:26:52 latexer Exp $

IUSE="xgetdefault"

DESCRIPTION="rxvt clone with XFT and Unicode support"
HOMEPAGE="http://www.sourceforge.net/projects/rxvt-unicode/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/glibc
	virtual/x11"

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
