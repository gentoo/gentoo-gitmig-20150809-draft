# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/truecrypt/truecrypt-5.0.ebuild,v 1.1 2008/02/08 18:42:12 alonbl Exp $

#
# NOTES:
# - Upstream overwrite CFLAGS, and does not wish us to mess with them.
# - Upstream insist on hiding the Makefile commands... Don't wish to patch it
#   again.
# - Some issues with parallel make of user mode library.
# - Upstream is not responsive, even new kernel versions are not supported
#   by upstream, but by other users.
#

inherit eutils toolchain-funcs multilib wxwidgets

DESCRIPTION="Free open-source disk encryption software"
HOMEPAGE="http://www.truecrypt.org/"
SRC_URI="${P}.tar.gz"

LICENSE="truecrypt-collective-1.3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
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

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-build.patch"
}

src_compile() {
	WX_GTK_VER="2.8"
	need-wxwidgets unicode
	emake \
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

# Requires DISPLAY anyway...
#src_test() {
#	"${S}/Main/truecrypt" --text --test
#}

src_install() {
	dobin Main/truecrypt
	dodoc Readme.txt 'Release/Setup Files/TrueCrypt User Guide.pdf'
	insinto "/$(get_libdir)/rcscripts/addons"
	newins "${FILESDIR}/${PN}-stop.sh" "${PN}-stop.sh"
}
