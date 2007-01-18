# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/geoip/geoip-1.4.0-r1.ebuild,v 1.7 2007/01/18 21:02:54 dertobi123 Exp $

inherit autotools eutils libtool

MY_P="${P/geoip/GeoIP}"
DESCRIPTION="easily lookup countries by IP addresses, even when Reverse DNS entries don't exist"
HOMEPAGE="http://www.maxmind.com/geoip/api/c.shtml"
SRC_URI="http://www.maxmind.com/download/geoip/api/c/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha ~amd64 hppa ~ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-asneeded.patch"
	epatch "${FILESDIR}/${P}-update-vulnerability.patch"
	eautomake

	elibtoolize
}

src_compile() {
	econf --enable-shared || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "einstall failed"
}
