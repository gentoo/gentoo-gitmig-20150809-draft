# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/wso2-wsf-c/wso2-wsf-c-1.2.0.ebuild,v 1.1 2008/03/01 14:22:09 caleb Exp $

inherit eutils
DESCRIPTION="A webservices framework in C"
HOMEPAGE="http://wso2.org/downloads/wsf/c/"
SRC_URI="http://dist.wso2.org/products/wsf/c/${PN}-src-${PV}.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="sqlite"

DEPEND="dev-libs/libxml2
	sys-libs/zlib
	dev-libs/openssl
	sqlite? ( dev-db/sqlite )"

RDEPEND="${DEPEND}"
S="${WORKDIR}/${PN}-src-${PV}"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
