# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/rxvt-unicode/rxvt-unicode-7.7-r2.ebuild,v 1.2 2006/04/14 20:31:24 flameeyes Exp $

inherit flag-o-matic

DESCRIPTION="rxvt clone with XFT and Unicode support"
HOMEPAGE="http://software.schmorp.de/"
SRC_URI="http://dist.schmorp.de/rxvt-unicode/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc-macos ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="truetype perl"

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
		"s:-g -O3:${CXXFLAGS}:" \
		configure
	epatch ${FILESDIR}/scrolling-one-line.patch
}

src_compile() {
	econf \
		--enable-everything \
		$(use_enable truetype xft) \
		$(use_enable perl) \
		--disable-text-blink \
		--disable-iso14755 \
		|| die

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

