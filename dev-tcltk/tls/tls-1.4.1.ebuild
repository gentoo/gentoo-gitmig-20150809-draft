# Copyright 2003 Arcady Genkin <agenkin@gentoo.org>.
# Distributed under the terms of the GNU General Public License v2.
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tls/tls-1.4.1.ebuild,v 1.2 2003/03/02 03:30:38 agenkin Exp $

DESCRIPTION="TLS OpenSSL extension to Tcl."
HOMEPAGE="http://tls.sourceforge.net/"

DEPEND=">=dev-lang/tcl-8.3.3
	>=dev-lang/tk-8.3.3
	dev-libs/openssl"

LICENSE="BSD"
KEYWORDS="x86"

SLOT="0"
SRC_URI="mirror://sourceforge/tls/${PN}${PV}-src.tar.gz"
S=${WORKDIR}/tls1.4

src_compile() {

	econf --with-ssl-dir=/usr || die
	make || die

}

src_install() {

	einstall || die
	dodoc ChangeLog README.txt license.terms

}
