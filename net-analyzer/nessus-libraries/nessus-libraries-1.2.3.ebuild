# Copyright 2000-2002 Achim Gottinger
# Distributed under the GPL by Gentoo Technologies, Inc.
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nessus-libraries/nessus-libraries-1.2.3.ebuild,v 1.1 2002/07/26 19:52:00 raker Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A remote security scanner for Linux (nessus-libraries)"
HOMEPAGE="http://www.nessus.org/"

SRC_URI="ftp://ftp.nessus.org/pub/nessus/nessus-1.2.3/src/${P}.tar.gz"

DEPEND="ssl? ( >=dev-libs/openssl-0.9.6d )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc -sparc -sparc64"


src_compile() {

	use ssl && myconf="--with-ssl=/usr/lib" \
		|| myconf="--without-ssl" 

	econf \
		${myconf} || die "configure failed"


	emake || die "emake failed"

}

src_install() {

	make \
		prefix=${D}/usr \
		sysconfdir=${D}/etc \
		localstatedir=${D}/var/state \
		mandir=${D}/usr/share/man \
		install || die "make install failed"

	cd ${S}
	docinto nessus-libraries
	dodoc README*

}
