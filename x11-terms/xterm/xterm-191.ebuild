# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/xterm/xterm-191.ebuild,v 1.1 2004/06/09 21:04:22 seemant Exp $

inherit eutils flag-o-matic

IUSE="truetype Xaw3d unicode"

DESCRIPTION="Terminal Emulator for X Windows"
HOMEPAGE="http://dickey.his.com/xterm/"
SRC_URI="ftp://invisible-island.net/${PN}/${P}.tgz"

LICENSE="X11"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~hppa amd64 ~mips"

DEPEND="virtual/x11
	sys-apps/utempter
	Xaw3d? ( x11-libs/Xaw3d )"

src_compile() {

	filter-flags "-fstack-protector"

	econf \
		`use_enable truetype freetype` \
		`use_enable unicode luit` \
		`use_with Xaw3d` \
		--libdir=/etc \
		--with-utempter \
		--enable-ansi-color \
		--enable-88-color \
		--enable-256-color \
		--enable-broken-osc \
		--enable-broken-st \
		--enable-load-vt-fonts \
		--enable-i18n \
		--enable-luit \
		--enable-tcap-query \
		--enable-wide-chars \
		--enable-doublechars \
		--enable-warnings \
		--disable-imake \
		--disable-toolbar \
		|| die
	emake || die
}

src_install() {
	make DESTDIR=${D} install-full || die
	dodoc README* INSTALL*
}
