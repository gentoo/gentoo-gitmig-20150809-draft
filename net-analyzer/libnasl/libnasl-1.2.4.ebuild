# Copyright 2000-2002 Achim Gottinger
# Distributed under the GPL by Gentoo Technologies, Inc.
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/libnasl/libnasl-1.2.4.ebuild,v 1.1 2002/08/22 14:38:12 raker Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A remote security scanner for Linux (libnasl)"
HOMEPAGE="http://www.nessus.org/"

SRC_URI="ftp://ftp.nessus.org/pub/nessus/nessus-${PV}/src/${P}.tar.gz"

DEPEND="=net-analyzer/nessus-libraries-${PV}"

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
		localstatedir=${D}/var/state \
		mandir=${D}/usr/share/man \
		install || die "Install failed libnasl"

	cd ${S}
	docinto libnasl
	dodoc COPYING TODO

}
