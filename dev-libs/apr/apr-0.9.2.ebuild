# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/apr/apr-0.9.2.ebuild,v 1.3 2003/09/06 22:29:24 msterret Exp $

inherit libtool

P1="apr-${PV}-alpha.tar.gz"
P2="apr-util-${PV}-alpha.tar.gz"
S="${WORKDIR}/${P}"
S2="${WORKDIR}/${PN}-util-${PV}"

DESCRIPTION="Apache's Portable Runtime Library."
SRC_URI="http://www.apache.org/dist/apr/${P1}
		http://www.apache.org/dist/apr/${P2}"
HOMEPAGE="http://apr.apache.org/"

DEPEND=">=sys-devel/autoconf-2.50
	>=sys-devel/libtool-1.4"
IUSE=""
SLOT="0"
LICENSE="Apache-1.1"
KEYWORDS="x86 ~sparc ~ppc"

src_unpack() {
	unpack ${P1}
	unpack ${P2}
}

src_compile() {
	cd ${S}
	econf || die
	emake || die

	cd ${S2}
	econf --with-apr=${S} || die
	emake || die
	mv STATUS STATUS.apr-util
	mv CHANGES CHANGES.apr-util
}

src_install () {
	cd ${S}
	dobin apr-config
	dolib libapr-0.la
	dolib.so .libs/libapr-0.so.${PV}
	dohtml docs/APRDesign.html docs/canonical_filenames.html docs/win32_builds.html
	dodoc docs/doxygen.conf docs/incomplete_types docs/non_apr_programs CHANGES STATUS

	dodir /usr/include/${PN}
	insinto /usr/include/${PN}
	doins ${S}/include/*

	cd ${S2}
	dobin apu-config
	dolib libaprutil-0.la
	dolib.so .libs/libaprutil-0.so.${PV}
	dodoc CHANGES.apr-util STATUS.apr-util
	dodir /usr/include/${PN}-util
	insinto /usr/include/${PN}-util
	doins ${S2}/include/*
}
