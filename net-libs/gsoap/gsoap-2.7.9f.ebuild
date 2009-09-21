# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gsoap/gsoap-2.7.9f.ebuild,v 1.3 2009/09/21 23:48:53 fauli Exp $

EAPI=1

inherit eutils

MY_P="${PN}-2.7"
DESCRIPTION="A cross-platform open source C and C++ SDK to ease the development of SOAP/XML Web services"
HOMEPAGE="http://gsoap2.sourceforge.net"
SRC_URI="mirror://sourceforge/gsoap2/gsoap_${PV}.tar.gz"

LICENSE="GPL-2 gSOAP"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="doc debug +ssl"

DEPEND="sys-devel/flex
	sys-devel/bison
	sys-libs/zlib
	ssl? ( dev-libs/openssl )"
RDEPEND=""

S=${WORKDIR}/${MY_P}

src_compile() {
	econf $(use_enable ssl openssl) \
	$(use_enable debug) \
	|| die "econf failed"

	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" -j1 install || die "Install failed"

	dodir /usr/share/doc/${P}
	dodoc NOTES.txt README.txt
	dohtml changelog.html

	if use doc; then
		dohtml -r gsoap/doc/
	fi
}
