# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/xterm/xterm-184.ebuild,v 1.10 2004/04/09 19:54:39 lu_zero Exp $

inherit eutils

IUSE="truetype"

S=${WORKDIR}/${P}
DESCRIPTION="Terminal Emulator for X Windows"
HOMEPAGE="http://dickey.his.com/xterm/"
SRC_URI="ftp://invisible-island.net/${PN}/${P}.tgz"

SLOT="0"
LICENSE="X11"
KEYWORDS="~x86 ~amd64 ~ppc"

DEPEND="x11-base/xorg-x11
	sys-apps/utempter"

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

	econf \
		`use_enable truetype freetype` \
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
