# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/treewm/treewm-0.4.5.ebuild,v 1.10 2006/12/12 23:46:29 masterdriverz Exp $

DESCRIPTION="WindowManager that arranges the windows in a tree (not in a list)"
SRC_URI="mirror://sourceforge/treewm/${P}.tar.bz2"
HOMEPAGE="http://treewm.sourceforge.net/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ppc"
IUSE=""

DEPEND="x11-proto/xf86vidmodeproto
	x11-libs/libXau
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXxf86vm
	x11-libs/libXdmcp
	x11-libs/libXpm"

src_unpack() {
	unpack ${A}
	# bug 86453
	sed -i -e "s:malloc:Malloc:g" "${S}"/xprop/dsimple.c
}

src_compile() {
	emake PREFIX="/usr" ROOT="${D}" || die
}

src_install() {
	cd ${S}
	make PREFIX="/usr" ROOT="${D}" install || die

	# hack for Gentoo's doc policy:
	cd "${D}/usr/share/doc/treewm" && dodoc * && cd .. && rm -rf treewm || die
}
