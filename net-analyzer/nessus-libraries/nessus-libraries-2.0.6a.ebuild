# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nessus-libraries/nessus-libraries-2.0.6a.ebuild,v 1.2 2003/05/27 08:04:19 aliz Exp $

DESCRIPTION="A remote security scanner for Linux (nessus-libraries)"
HOMEPAGE="http://www.nessus.org/"
SRC_URI="ftp://ftp.nessus.org/pub/nessus/nessus-${PV}/src/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc -sparc alpha"
IUSE="ssl"
DEPEND="ssl? ( >=dev-libs/openssl-0.9.6d )"
S=${WORKDIR}/${PN}

src_compile() {
	local myconf=""
	use ssl && myconf="--with-ssl=/usr/lib" \
		|| myconf="--without-ssl" 
	econf ${myconf}
	emake || die "emake failed"
}

src_install() {
	einstall
	dodoc README*
}
