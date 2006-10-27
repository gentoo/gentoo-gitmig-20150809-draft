# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/xca/xca-0.5.1-r1.ebuild,v 1.2 2006/10/27 01:34:44 alonbl Exp $

inherit eutils kde toolchain-funcs

DESCRIPTION="A graphical user interface to OpenSSL, RSA public keys, certificates, signing requests and revokation lists"
HOMEPAGE="http://www.hohnstaedt.de/xca.html"
SRC_URI="mirror://sourceforge/xca/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-libs/openssl-0.9.8
	=x11-libs/qt-3*
	>=sys-libs/db-4.1"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-build.patch"
	epatch "${FILESDIR}/${P}-gcc4.patch"
	epatch "${FILESDIR}/${P}-openssl.patch"
	epatch "${FILESDIR}/${P}-qt.patch"
}

src_compile() {
	kde_src_compile nothing
	STRIP="true" CC="$(tc-getCC)" prefix=/usr ./configure || die "configure died"
	echo "inst_prefix=/usr" >> Local.mak
	inst_prefix="/usr" emake || die "emake failed"
}

src_install() {
	make destdir="${D}" mandir="share/man" install

	dodoc README CREDITS AUTHORS COPYRIGHT

	insinto /etc/xca
	doins misc/*.txt
}
