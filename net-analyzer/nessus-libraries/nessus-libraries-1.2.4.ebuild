# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nessus-libraries/nessus-libraries-1.2.4.ebuild,v 1.2 2002/09/30 13:11:29 raker Exp $

S=${WORKDIR}/${PN}

DESCRIPTION="A remote security scanner for Linux (nessus-libraries)"
HOMEPAGE="http://www.nessus.org/"
SRC_URI="ftp://ftp.nessus.org/pub/nessus/nessus-${PV}/src/${P}.tar.gz"

DEPEND="ssl? ( >=dev-libs/openssl-0.9.6d )"
RDEPEND=${DEPEND}"

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
		localstatedir=${D}/var/lib \
		mandir=${D}/usr/share/man \
		install || die "make install failed"

	cd ${S}
	docinto nessus-libraries
	dodoc README*

}
