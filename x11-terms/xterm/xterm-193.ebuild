# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/xterm/xterm-193.ebuild,v 1.1 2004/07/23 20:40:44 seemant Exp $

inherit eutils flag-o-matic

DESCRIPTION="Terminal Emulator for X Windows"
HOMEPAGE="http://dickey.his.com/xterm/"
SRC_URI="ftp://invisible-island.net/${PN}/${P}.tgz"

LICENSE="X11"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~arm ~hppa ~amd64 ~ia64 ~ppc64"
IUSE="truetype Xaw3d unicode"

DEPEND="|| ( x11-base/xorg-x11 >=x11-base/xfree-4.3.0-r7 )
	sys-apps/utempter
	Xaw3d? ( x11-libs/Xaw3d )"
# Doesn't work because of broken portage (#8810)
# virtual/x11"

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
}
