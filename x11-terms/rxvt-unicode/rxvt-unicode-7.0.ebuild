# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/rxvt-unicode/rxvt-unicode-7.0.ebuild,v 1.1 2006/01/13 20:03:00 ciaranm Exp $

inherit flag-o-matic

DESCRIPTION="rxvt clone with XFT and Unicode support"
HOMEPAGE="http://software.schmorp.de/"
SRC_URI="http://dist.schmorp.de/rxvt-unicode/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc-macos ~ppc64 ~sparc ~x86"
IUSE="xgetdefault perl"

# see bug #115992 for modular x deps
RDEPEND="
	|| (
		(
			x11-libs/libX11
			x11-libs/libXft
			x11-libs/libXpm
			x11-libs/libXrender
		)
		virtual/x11
	)
	dev-lang/perl
	perl? ( sys-devel/libperl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/libtool
	|| (
		(
			x11-proto/xproto
			x11-libs/libXt
		)
		virtual/x11
	)"

src_unpack() {
	unpack ${A}
	cd ${S}
	local tdir=/usr/share/terminfo
	sed -i -e \
		"s~@TIC@ \(etc/rxvt\)~@TIC@ -o ${D}/${tdir} \1~" \
		doc/Makefile.in
	sed -i -e \
		"s:-g -O3:${CFLAGS}:" \
		configure
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
		--enable-24bit \
		--enable-xim \
		--enable-shared \
		--enable-keepscrolling \
		--enable-xft \
		$(use_enable xgetdefault ) \
		$(use_enable perl ) \
		--disable-text-blink \
		--disable-iso14755 \
		--disable-menubar || die

	emake || die

	sed -i \
		-e 's/RXVT_BASENAME = "rxvt"/RXVT_BASENAME = "urxvt"/' \
		${S}/doc/rxvt-tabbed || die "tabs sed failed"
}

src_install() {
	make DESTDIR="${D}" install || die

	dodoc README.FAQ Changes
	cd "${S}"/doc
	dodoc README* changes.txt etc/* rxvt-tabbed
}

pkg_postinst() {
	einfo "urxvt now always uses TERM=rxvt-unicode so that the"
	einfo "upstream-supplied terminfo files can be used."
}
