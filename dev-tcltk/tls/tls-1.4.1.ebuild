# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tls/tls-1.4.1.ebuild,v 1.13 2005/04/02 15:47:46 weeve Exp $

DESCRIPTION="TLS OpenSSL extension to Tcl."
HOMEPAGE="http://tls.sourceforge.net/"
SRC_URI="mirror://sourceforge/tls/${PN}${PV}-src.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 hppa alpha ppc amd64 sparc"
IUSE=""
DEPEND=">=dev-lang/tcl-8.3.3
		>=dev-lang/tk-8.3.3
		dev-libs/openssl"

S=${WORKDIR}/tls1.4

src_compile() {
	econf --with-ssl-dir=/usr || die
	make || die
}

src_install() {
	einstall || die
	dodoc ChangeLog README.txt license.terms
}
