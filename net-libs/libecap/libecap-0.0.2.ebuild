# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libecap/libecap-0.0.2.ebuild,v 1.1 2009/07/16 21:16:10 mrness Exp $

EAPI="2"

inherit eutils

DESCRIPTION="API for implementing ICAP content analysis and adaptation"
HOMEPAGE="http://www.e-cap.org/"
SRC_URI="http://www.measurement-factory.com/tmp/ecap/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}/${PN}-limits.patch"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc CREDITS NOTICE README change.log || die "dodoc failed"
}
