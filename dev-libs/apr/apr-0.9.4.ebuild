# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/apr/apr-0.9.4.ebuild,v 1.7 2004/07/21 22:13:42 dholm Exp $

IUSE=""

DESCRIPTION="Apache Portable Runtime Library"
HOMEPAGE="http://apr.apache.org/"
SRC_URI="mirror://apache/apr/${P}.tar.gz
	mirror://apache/apr/${PN}-util-${PV}.tar.gz"

LICENSE="Apache-1.1"
KEYWORDS="~x86 amd64 ~sparc ~ppc"
SLOT="0"
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
