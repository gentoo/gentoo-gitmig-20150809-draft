# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmwifi/wmwifi-0.5.ebuild,v 1.3 2005/12/20 10:59:47 s4t4n Exp $

IUSE=""
HOMEPAGE="http://wmwifi.digitalssg.net"
DESCRIPTION="wireless network interface monitor dockapp"
SRC_URI="http://digitalssg.net/debian/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc x86 ~amd64"

DEPEND="virtual/x11"

src_unpack()
{
	unpack ${A}

	# eek - package is already compiled!
	rm ${S}/src/*.o ${S}/src/wmwifi
}

src_compile()
{
	econf || die "Configuration failed"

	# by default it does not honour our CFLAGS
	emake CFLAGS="${CFLAGS}" CPPFLAGS="${CFLAGS}" || die "Compilation failed"
}

src_install()
{
	dobin src/wmwifi
	doman wmwifi.1
	dodoc AUTHORS README
}
