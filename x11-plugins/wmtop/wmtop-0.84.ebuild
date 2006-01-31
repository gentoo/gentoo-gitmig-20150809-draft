# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmtop/wmtop-0.84.ebuild,v 1.11 2006/01/31 21:00:15 nelchael Exp $

IUSE=""
DESCRIPTION="top in a dockapp"
HOMEPAGE="http://wmtop.sourceforge.net"
SRC_URI="mirror://sourceforge/wmtop/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc amd64 ppc"

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXpm )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( (
		x11-proto/xproto
		x11-proto/xextproto )
	virtual/x11 )
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
