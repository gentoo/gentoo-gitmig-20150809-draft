# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/serf/serf-0.1.2.ebuild,v 1.2 2008/05/02 18:55:27 fmccor Exp $

inherit autotools eutils

DESCRIPTION="HTTP client library"
HOMEPAGE="http://code.google.com/p/serf/"
SRC_URI="http://serf.googlecode.com/files/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND="dev-libs/apr
	dev-libs/apr-util
	dev-libs/openssl
	sys-libs/zlib"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PV}-disable-unneeded-linking.patch
	eautoreconf
}

src_compile() {
	econf \
		--with-apr=/usr/bin/apr-1-config \
		--with-apr-util=/usr/bin/apu-1-config \
		--with-openssl=/usr
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc CHANGES README
}
