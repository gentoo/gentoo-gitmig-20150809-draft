# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gsoap/gsoap-2.7.13.ebuild,v 1.4 2010/06/03 21:25:46 polynomial-c Exp $

EAPI=2

inherit eutils

MY_P="${PN}-2.7"
DESCRIPTION="A cross-platform open source C and C++ SDK to ease the development of SOAP/XML Web services"
HOMEPAGE="http://gsoap2.sourceforge.net"
SRC_URI="mirror://sourceforge/gsoap2/gsoap_${PV}.tar.gz"

LICENSE="GPL-2 gSOAP"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc debug examples +ssl"

DEPEND="sys-devel/flex
	sys-devel/bison
	sys-libs/zlib
	ssl? ( dev-libs/openssl )"
RDEPEND=""

S=${WORKDIR}/${MY_P}

src_prepare() {
	# Fix Pre-ISO headers
	epatch "${FILESDIR}/${PN}-2.7-fix-pre-iso-headers.patch"
}

src_configure() {
	econf $(use_enable ssl openssl) \
	$(use_enable examples samples) \
	$(use_enable debug) \
	|| die "econf failed"
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"

	dodir /usr/share/doc/${P}
	dodoc LICENSE.txt NOTES.txt README.txt
	dohtml changelog.html

	if use examples; then
		insinto /usr/share/${PN}
		rm -rf gsoap/samples/Makefile* README.txt
		doins -r gsoap/samples
	fi

	if use doc; then
		dohtml -r gsoap/doc/
	fi
}
