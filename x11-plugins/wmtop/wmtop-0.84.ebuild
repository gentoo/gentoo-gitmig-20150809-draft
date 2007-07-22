# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmtop/wmtop-0.84.ebuild,v 1.12 2007/07/22 04:25:22 dberkholz Exp $

IUSE=""
DESCRIPTION="top in a dockapp"
HOMEPAGE="http://wmtop.sourceforge.net"
SRC_URI="mirror://sourceforge/wmtop/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc amd64 ppc"

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xextproto
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A} ; cd ${S}
	sed -i -e "s:-O3 -g -Wall:${CFLAGS}:" \
		-e "s:/local::" Makefile
}

src_compile() {
	make linux
}

src_install() {

	dodir /usr/bin /usr/man/man1
	make PREFIX=${D}/usr install || die "make install failed"

}
