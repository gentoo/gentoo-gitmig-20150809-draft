# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tls/tls-1.5.0-r1.ebuild,v 1.7 2009/09/12 17:11:36 armin76 Exp $

inherit eutils

DESCRIPTION="TLS OpenSSL extension to Tcl."
HOMEPAGE="http://tls.sourceforge.net/"
SRC_URI="mirror://sourceforge/tls/${PN}${PV}-src.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha ~amd64 hppa ppc sparc x86"
IUSE="tk"

RESTRICT="test"

DEPEND=">=dev-lang/tcl-8.3.3
	dev-libs/openssl
	tk? ( >=dev-lang/tk-8.3.3 )"

S="${WORKDIR}/${PN}${PV%.*}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-bad-version.patch

}

src_compile() {
	econf --with-ssl-dir=/usr || die
	emake || die
}

src_install() {
	einstall || die
	dodoc ChangeLog README.txt
	dohtml tls.htm
}
