# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/truecrypt/truecrypt-6.2.ebuild,v 1.1 2009/05/18 02:30:33 arfrever Exp $

EAPI="2"

inherit flag-o-matic multilib toolchain-funcs wxwidgets

DESCRIPTION="Free open-source disk encryption software"
HOMEPAGE="http://www.truecrypt.org/"
SRC_URI="${P}.tar.gz"

LICENSE="truecrypt-2.6"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X"
RESTRICT="bindist fetch mirror"

RDEPEND="sys-fs/fuse
	x11-libs/wxGTK:2.8"
DEPEND="${RDEPEND}
	dev-libs/opensc"

S="${WORKDIR}/${P}-source"

pkg_nofetch() {
	einfo "Please download tar.gz source from:"
	einfo "http://www.truecrypt.org/downloads2.php"
	einfo "Then put the file in ${DISTDIR}/${SRC_URI}"
}

pkg_setup() {
	WX_GTK_VER="2.8"
	if use X; then
		need-wxwidgets unicode
	else
		need-wxwidgets base-unicode
	fi
}

src_compile() {
	append-flags -DCKR_NEW_PIN_MODE=0x000001B0 -DCKR_NEXT_OTP=0x000001B1
	local EXTRA
	use X || EXTRA+=" NOGUI=1"
	emake \
		${EXTRA} \
		NOSTRIP=1 \
		NOTEST=1 \
		VERBOSE=1 \
		CC="$(tc-getCC)" \
		CXX="$(tc-getCXX)" \
		AR="$(tc-getAR)" \
		RANLIB="$(tc-getRANLIB)" \
		TC_EXTRA_CFLAGS="${CFLAGS}" \
		TC_EXTRA_CXXFLAGS="${CXXFLAGS}" \
		TC_EXTRA_LFLAGS="${LDFLAGS}" \
		WX_CONFIG="${WX_CONFIG}" \
		PKCS11_INC="/usr/include/opensc" \
		|| die "emake failed"
}

src_test() {
	"${S}/Main/truecrypt" --text --test || die "tests failed"
}

src_install() {
	dobin Main/truecrypt
	dodoc Readme.txt "Release/Setup Files/TrueCrypt User Guide.pdf"
	insinto "/$(get_libdir)/rcscripts/addons"
	newins "${FILESDIR}/${PN}-stop.sh" "${PN}-stop.sh"
}

pkg_postinst() {
	ewarn "TrueCrypt has very restrictive license."
	ewarn "Please read the ${LICENSE} license in ${PORTDIR}/licenses directory before using TrueCrypt."
	ebeep 12
}
