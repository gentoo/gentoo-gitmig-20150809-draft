# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmwifi/wmwifi-0.5.ebuild,v 1.6 2006/10/18 08:19:54 s4t4n Exp $

IUSE=""
HOMEPAGE="http://wmwifi.digitalssg.net"
DESCRIPTION="wireless network interface monitor dockapp"
SRC_URI="http://digitalssg.net/debian/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ppc x86"

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXt
		x11-libs/libXext
		x11-libs/libXpm )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( (
		x11-proto/xextproto
		x11-proto/xproto )
	virtual/x11 )
	sys-devel/automake"

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
