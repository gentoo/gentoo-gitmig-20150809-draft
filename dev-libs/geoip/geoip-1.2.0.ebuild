# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/geoip/geoip-1.2.0.ebuild,v 1.1 2003/06/29 20:01:35 solar Exp $

inherit eutils

MY_P=${P/geoip/GeoIP}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Geo-IP enables you to easily lookup countries by IP addresses, even when Reverse DNS entries don't exist. 
 The Geo-IP database contains IP Network Blocks as keys and countries as values, covering every public IP address."

SRC_URI="http://www.maxmind.com/download/geoip/api/c/${MY_P}.tar.gz"
HOMEPAGE="http://www.maxmind.com/geoip/api/c.shtml"
KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"
MAINTAINER="solar@gentoo.org"
IUSE=""

DEPEND="virtual/glibc
	sys-libs/zlib"

src_compile() {
	econf --enable-shared || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
}
