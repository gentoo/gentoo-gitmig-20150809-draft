# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/geoip/geoip-1.2.1.ebuild,v 1.10 2005/02/05 10:31:31 hansmi Exp $

inherit eutils

MY_P=${P/geoip/GeoIP}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Geo-IP enables you to easily lookup countries by IP addresses, even when Reverse DNS entries don't exist. The Geo-IP database contains IP Network Blocks as keys and countries as values, covering every public IP address."
SRC_URI="http://www.maxmind.com/download/geoip/api/c/${MY_P}.tar.gz"
HOMEPAGE="http://www.maxmind.com/geoip/api/c.shtml"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc amd64"
IUSE=""

DEPEND="virtual/libc
	sys-libs/zlib"

src_compile() {
	econf --enable-shared || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
}
