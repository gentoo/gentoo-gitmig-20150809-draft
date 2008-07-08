# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/ratproxy/ratproxy-1.51.ebuild,v 1.1 2008/07/08 19:57:42 drizzt Exp $

inherit eutils flag-o-matic

DESCRIPTION="A semi-automated, largely passive web application security audit tool."
HOMEPAGE="http://code.google.com/p/ratproxy/"
SRC_URI="http://ratproxy.googlecode.com/files/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-libs/openssl"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e "s:keyfile\.pem:/usr/share/${PN}/&:" ssl.c
	epatch "${FILESDIR}"/${PN}-Makefile.patch
}

src_compile() {
	tc-export CC

	emake || die "emake failed"
}

src_install() {
	dobin ${PN} || die "install failed"
	dodoc doc/*
	insinto /usr/share/${PN}
	doins keyfile.pem
}
