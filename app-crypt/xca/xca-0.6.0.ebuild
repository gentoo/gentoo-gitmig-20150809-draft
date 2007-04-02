# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/xca/xca-0.6.0.ebuild,v 1.1 2007/04/02 11:09:42 alonbl Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A graphical user interface to OpenSSL, RSA public keys, certificates, signing requests and revokation lists"
HOMEPAGE="http://www.hohnstaedt.de/xca.html"
SRC_URI="mirror://sourceforge/xca/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-libs/openssl-0.9.8
	=x11-libs/qt-4*"

pkg_setup() {
	# Upstream:
	# http://sourceforge.net/tracker/index.php?func=detail&aid=1692800&group_id=62274&atid=500028
	if has_version ">=x11-libs/qt-4.2.2" ; then
		if ! built_with_use x11-libs/qt qt3support ; then
			eerror ">=qt4.2.2 requires qt3support"
			die "rebuild >=x11-libs/qt-4.2.2 with the qt3support USE flag"
		fi
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Upstream:
	# http://sourceforge.net/tracker/index.php?func=detail&aid=1692798&group_id=62274&atid=500027
	epatch "${FILESDIR}/${P}-build.patch"
}

src_compile() {
	QTDIR=/usr \
		STRIP="true" \
		CC="$(tc-getCC)" \
		LD="$(tc-getLD)" \
		prefix=/usr \
		./configure || die	"configure failed"
	emake || die "emake failed"
}

src_install() {
	emake destdir="${D}" mandir="share/man" install

	dodoc README CREDITS AUTHORS COPYRIGHT

	insinto /etc/xca
	doins misc/*.txt
}
