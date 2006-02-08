# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmnd/wmnd-0.4.11-r1.ebuild,v 1.7 2006/02/08 18:58:14 blubb Exp $

IUSE="snmp"
DESCRIPTION="WindowMaker Network Devices (dockapp)"
HOMEPAGE="http://www.yuv.info/wmnd/"
SRC_URI="ftp://ftp.yuv.info/pub/wmnd/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXt
		x11-libs/libXpm )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( x11-proto/xextproto virtual/x11 )
	snmp? ( >=net-analyzer/net-snmp-5.2.1 )"

src_compile()
{
	if use snmp; then
		LDFLAGS="$LDFLAGS -lcrypto"
	fi

	LDFLAGS="$LDFLAGS" econf || die "configure failed"
	emake || die "parallel make failed"
}

src_install()
{
	einstall || die "make install failed"

	dodoc README AUTHORS ChangeLog NEWS TODO

	# gpl.info is no valid .info file. Causes errors with install-info.
	rm -r ${D}/usr/share/info
}
