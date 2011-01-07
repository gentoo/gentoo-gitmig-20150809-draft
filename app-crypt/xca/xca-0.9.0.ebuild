# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/xca/xca-0.9.0.ebuild,v 1.5 2011/01/07 16:39:47 ranger Exp $

EAPI="3"

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="A GUI to OpenSSL, RSA public keys, certificates, signing requests and revokation lists"
HOMEPAGE="http://www.hohnstaedt.de/xca.html"
SRC_URI="mirror://sourceforge/xca/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="doc"

RDEPEND=">=dev-libs/openssl-0.9.8[-bindist]
	x11-libs/qt-gui:4"
DEPEND="${RDEPEND}
	doc? ( app-text/linuxdoc-tools )"

src_prepare() {
	# http://sourceforge.net/tracker/index.php?func=detail&aid=1800298&group_id=62274&atid=500028
	epatch "${FILESDIR}/${P}-qt_detection.patch"
}

src_configure() {
	local LINUXDOC
	use doc || LINUXDOC='touch $@ && true'

	QTDIR=/usr \
		STRIP="true" \
		LINUXDOC="${LINUXDOC}" \
		CC="$(tc-getCC)" \
		LD="$(tc-getLD)" \
		CFLAGS="${CXXFLAGS}" \
		LDFLAGS="$(raw-ldflags)" \
		prefix=/usr \
		docdir=/usr/share/doc/${PF} \
		./configure || die	"configure failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake destdir="${D}" mandir="share/man" install || die "emake install failed"

	dodoc AUTHORS || die

	insinto /etc/xca
	doins misc/*.txt || die
}
