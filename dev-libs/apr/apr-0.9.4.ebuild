# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/apr/apr-0.9.4.ebuild,v 1.1 2003/10/12 17:21:07 mholzer Exp $

IUSE=""

DESCRIPTION="Apache Portable Runtime Library"
HOMEPAGE="http://apr.apache.org/"
SRC_URI="http://www.apache.org/dist/apr/${P}.tar.gz
		http://www.apache.org/dist/apr/${PN}-util-${PV}.tar.gz"

LICENSE="Apache-1.1"
KEYWORDS="~x86"
SLOT="0"
S="${WORKDIR}/${P}"
S2="${WORKDIR}/${PN}-util-${PV}"

DEPEND=""

src_compile() {

	econf || die
	emake || die

	cd ${S2}
	econf --with-apr=${S} || die
	emake || die

}

src_install() {

	make DESTDIR=${D} install

	dodoc CHANGES STATUS LICENSE
	dodoc docs/{doxygen.conf,incomplete_types,non_apr_programs}
	dohtml docs/*.html

	cd ${S2}
	make DESTDIR=${D} install

	newdoc CHANGES CHANGES.apr-util
	newdoc STATUS STATUS.apr-util


	rm -rf ${D}/usr/share/build

}
