# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/rxvt-unicode/rxvt-unicode-5.2.ebuild,v 1.1 2005/02/20 23:31:50 ciaranm Exp $

inherit 64-bit eutils

IUSE="xgetdefault tabs"

DESCRIPTION="rxvt clone with XFT and Unicode support"
HOMEPAGE="http://software.schmorp.de/"
SRC_URI="http://dist.schmorp.de/rxvt-unicode/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc"

DEPEND="virtual/libc
	virtual/x11
	dev-lang/perl
	tabs? ( dev-perl/gtk2-perl )"

src_unpack() {
	unpack ${A}
	cd ${S}
	local tdir=/usr/share/terminfo
	sed -i -e \
		"s~@TIC@ \(etc/rxvt\)~@TIC@ -o ${D}/${tdir} \1~" \
		doc/Makefile.in
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

	if useq tabs ; then
		sed -i \
			-e 's/RXVT_BASENAME = "rxvt"/RXVT_BASENAME = "urxvt"/' \
			${S}/doc/rxvt-tabbed || die "tabs sed failed"
	fi
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc README.FAQ Changes
	cd ${S}/doc
	dodoc README* changes.txt BUGS TODO etc/*

	if useq tabs ; then
		newbin rxvt-tabbed urxvt-tabbed
	fi
}

pkg_postinst() {
	einfo "urxvt now always uses TERM=rxvt-unicode so that the"
	einfo "upstream-supplied terminfo files can be used."
}
