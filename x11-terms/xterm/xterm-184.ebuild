# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/xterm/xterm-184.ebuild,v 1.17 2004/04/15 02:10:22 geoman Exp $

inherit eutils

DESCRIPTION="Terminal Emulator for X Windows"
HOMEPAGE="http://dickey.his.com/xterm/"
SRC_URI="ftp://invisible-island.net/${PN}/${P}.tgz"

LICENSE="X11"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~hppa ~amd64 ~mips"
IUSE="truetype Xaw3d"

DEPEND="x11-base/xorg-x11
	sys-apps/utempter
	Xaw3d? ( x11-libs/Xaw3d )"

src_unpack() {
	unpack ${A}; cd ${S}

	epatch ${FILESDIR}/${P}-remove-termcap-breakage.patch

	# Keep the blue from previous xterms, instead of the dodgerblue and
	# steelblue
	sed -i \
		-e "s:DodgerBlue1:blue3:" \
		-e "s:SteelBlue1:blue:" \
		${S}/XTerm-col.ad
}

src_compile() {
	local myconf

	use Xaw3d && myconf="${myconf} --with-Xaw3d"

	econf \
		`use_enable truetype freetype` \
		${myconf} \
		--libdir=/etc \
		--with-utempter \
		--enable-88-color \
		--enable-256-color \
		--enable-load-vt-fonts \
		--enable-toolbar \
		--enable-luit \
		--enable-wide-chars \
		--disable-imake \
		|| die
	emake || die
}

src_install() {
	make DESTDIR=${D} install-full || die
	dodoc README* INSTALL*
}
