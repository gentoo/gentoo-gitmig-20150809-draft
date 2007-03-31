# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tls/tls-1.5.0.ebuild,v 1.10 2007/03/31 02:06:06 jer Exp $

DESCRIPTION="TLS OpenSSL extension to Tcl."
HOMEPAGE="http://tls.sourceforge.net/"
SRC_URI="mirror://sourceforge/tls/${PN}${PV}-src.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc sparc x86"
IUSE="X"

DEPEND=">=dev-lang/tcl-8.3.3
	dev-libs/openssl
	X? ( >=dev-lang/tk-8.3.3 )"

S=${WORKDIR}/tls1.5

src_compile() {
	econf --with-ssl-dir=/usr || die
	make || die
}

src_install() {
	einstall || die
	dodoc ChangeLog README.txt license.terms
}
