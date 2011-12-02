# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/dragonegg/dragonegg-9999.ebuild,v 1.1 2011/12/02 23:54:26 voyageur Exp $

EAPI=4
inherit subversion multilib

DESCRIPTION="GCC plugin that uses LLVM for optimization and code generation"
HOMEPAGE="http://dragonegg.llvm.org/"
SRC_URI=""
ESVN_REPO_URI="http://llvm.org/svn/llvm-project/dragonegg/trunk"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="|| ( sys-devel/gcc:4.5[lto]
		>=sys-devel/gcc-4.6 )
	~sys-devel/llvm-${PV}"
RDEPEND="${DEPEND}"

src_prepare() {
	# Replace svnversion call
	subversion_wc_info
	sed -e "s/\(^REVISION:=\).*/\1${ESVN_WC_REVISION}/" \
		-i Makefile || die "Setting revision failed"
}

src_compile() {
	# GCC: compiler to use plugin with
	emake CC="$(tc-getCC)" GCC="$(tc-getCC)" CXX="$(tc-getCXX)" VERBOSE=1
}

src_install() {
	# Install plugin in llvm lib directory
	exeinto /usr/$(get_libdir)/llvm
	doexe dragonegg.so

	dodoc README
}

pkg_postinst() {
	elog "To use dragonegg, run gcc as usual, with an extra command line argument:"
	elog "	-fplugin=/usr/$(get_libdir)/llvm/dragonegg.so"
	elog "If you change the active gcc profile, or update gcc to a new version,"
	elog "you will have to remerge this package to update the plugin"
}
