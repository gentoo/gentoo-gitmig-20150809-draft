# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/xterm/xterm-196.ebuild,v 1.12 2004/12/29 20:33:33 seemant Exp $

inherit eutils flag-o-matic

DESCRIPTION="Terminal Emulator for X Windows"
HOMEPAGE="http://dickey.his.com/xterm/"
SRC_URI="ftp://invisible-island.net/${PN}/${P}.tgz"

LICENSE="X11"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86"
IUSE="truetype Xaw3d unicode"

DEPEND="virtual/x11
	sys-apps/utempter
	Xaw3d? ( x11-libs/Xaw3d )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-184-remove-termcap-breakage.patch
}

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
		--enable-wide-chars \
		--enable-doublechars \
		--enable-warnings \
		--enable-tcap-query \
		--disable-imake \
		--disable-toolbar \
		${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install-full || die
	dodoc README* INSTALL*

	# restore the navy blue
	sed -i "s:blue2$:blue:" ${D}/etc/X11/app-defaults/XTerm-color
}
