# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/libnasl/libnasl-1.2.4.ebuild,v 1.2 2002/09/30 13:07:52 raker Exp $

S=${WORKDIR}/${PN}

DESCRIPTION="A remote security scanner for Linux (libnasl)"
HOMEPAGE="http://www.nessus.org/"
SRC_URI="ftp://ftp.nessus.org/pub/nessus/nessus-${PV}/src/${P}.tar.gz"

DEPEND="=net-analyzer/nessus-libraries-${PV}"
RDEPEND="${DEPEND}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc -sparc -sparc64"

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/nasl.diff

}

src_compile() {

	econf || die "configuration failed"

	emake || die "emake failed"

}

src_install() {

	make \
		prefix=${D}/usr \
		sysconfdir=${D}/etc \
		localstatedir=${D}/var/lib \
		mandir=${D}/usr/share/man \
		install || die "Install failed libnasl"

	cd ${S}
	docinto libnasl
	dodoc COPYING TODO

}
