# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/hanterm-xf/hanterm-xf-2.0.5.ebuild,v 1.1 2004/08/02 16:28:36 usata Exp $

DESCRIPTION="Patched xterm for Korean input/output"
HOMEPAGE="http://www.kr.freebsd.org/~hwang/hanterm/"
XTERM_VER=173
SRC_URI="http://download.kldp.net/${PN}/${P}-${XTERM_VER}.tar.gz"
LICENSE="MIT | GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="Xaw3d truetype"

DEPEND="virtual/x11
	sys-apps/utempter
	Xaw3d? ( x11-libs/Xaw3d )
	media-fonts/baekmuk-fonts
	!x11-terms/hanterm"
S=${WORKDIR}/${P}-${XTERM_VER}

src_compile() {
	local myconf
	use Xaw3d && myconf="--with-Xaw3d"
	econf \
		`use_enable truetype freetype` \
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
	dobin hanterm
	insinto /usr/share/hangul_keyboard
	doins keyboard/*

	insinto /etc/X11/app-defaults
	newins Hanterm.ad Hanterm
	newins Hanterm-col.ad Hanterm-color

	newman hanterm.man hanterm.1
	dodoc README* INSTALL*
}
