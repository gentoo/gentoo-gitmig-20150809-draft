# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/truecrypt/truecrypt-5.1.ebuild,v 1.1 2008/03/13 07:01:39 alonbl Exp $

inherit eutils toolchain-funcs multilib wxwidgets

DESCRIPTION="Free open-source disk encryption software"
HOMEPAGE="http://www.truecrypt.org/"
SRC_URI="${P}.tar.gz"

LICENSE="truecrypt-collective-1.3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X"
RESTRICT="fetch"

RDEPEND="sys-fs/fuse
	=x11-libs/wxGTK-2.8*"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${P}-source"

pkg_nofetch() {
	einfo "Please download tar.gz source from:"
	einfo "http://www.truecrypt.org/downloads2.php"
	einfo "Then put the file in ${DISTDIR}/${P}.tar.gz"
}

pkg_setup() {
	WX_GTK_VER="2.8"
	if use X; then
		need-wxwidgets unicode
	else
		need-wxwidgets base-unicode
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-5.0-build.patch"
	epatch "${FILESDIR}/${P}-64bit.patch"
	epatch "${FILESDIR}/${PN}-5.0-bool.patch"
	epatch "${FILESDIR}/${P}-nogui.patch"
}

src_compile() {
	local EXTRA
	use amd64 && EXTRA="${EXTRA} USE64BIT=1"
	use X || EXTRA="${EXTRA} NOGUI=1"
	emake \
		${EXTRA} \
		NOSTRIP=1 \
		VERBOSE=1 \
		CC="$(tc-getCC)" \
		AR="$(tc-getAR)" \
		CXX="$(tc-getCXX)" \
		RANLIB="$(tc-getRANLIB)" \
		EXTRA_CFLAGS="${CFLAGS}" \
		EXTRA_CXXFLAGS="${CXXFLAGS}" \
		EXTRA_LDFLAGS="${LDFLAGS}" \
		WX_CONFIG="${WX_CONFIG}" \
		WX_CONFIG_EXTRA="" \
		|| die
}

src_test() {
	"${S}/Main/truecrypt" --text --test
}

src_install() {
	dobin Main/truecrypt
	dodoc Readme.txt 'Release/Setup Files/TrueCrypt User Guide.pdf'
	insinto "/$(get_libdir)/rcscripts/addons"
	newins "${FILESDIR}/${PN}-stop.sh" "${PN}-stop.sh"
}
