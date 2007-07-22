# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmbinclock/wmbinclock-0.3.ebuild,v 1.7 2007/07/22 05:22:35 dberkholz Exp $

IUSE=""

HOMEPAGE="http://www.inxsoft.net/wmbinclock"
DESCRIPTION="wmbinclock shows the actual system time as a binary clock"
SRC_URI="http://www.inxsoft.net/wmbinclock/${P}.tar.gz"

SLOT="0"
LICENSE="freedist"
KEYWORDS="x86 amd64 ppc ppc64 ~sparc"

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xextproto"

src_compile()
{
	myconf=""
	emake CFLAGS="${CFLAGS}" || die
}

src_install()
{
	dodoc README
	dodir /usr/bin
	make DESTDIR=${D}/usr install || die
}
