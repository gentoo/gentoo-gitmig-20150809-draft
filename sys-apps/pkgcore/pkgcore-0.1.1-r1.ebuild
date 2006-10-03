# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pkgcore/pkgcore-0.1.1-r1.ebuild,v 1.1 2006/10/03 14:28:52 marienz Exp $

inherit distutils eutils toolchain-funcs

DESCRIPTION="pkgcore package manager"
HOMEPAGE="http://dev.gentooexperimental.org/pkgcore-trac/"
SRC_URI="http://dev.gentooexperimental.org/~${PN}/releases/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="doc"

DEPEND=">=dev-lang/python-2.4"
RDEPEND=">=dev-lang/python-2.4
	|| ( >=dev-lang/python-2.5 dev-python/pycrypto )
	>=app-shells/bash-3.0
	doc? ( >=dev-python/docutils-0.4 )"


src_unpack() {
	unpack ${A}
	cd "${S}"

	# This is needed to make filter-env work on hppa (and possibly others).
	epatch "${FILESDIR}/${P}-filter-env-cflags.patch"

	# Make pkgcore (and its tests) work without TERM set.
	epatch "${FILESDIR}/${P}-curses-errors.patch"
}

src_compile() {
	# The CC export is used by the filter-env build
	CC=$(tc-getCC) distutils_src_compile

	if use doc; then
		./build_docs.py || die "doc building failed"
	fi
}

src_install() {
	distutils_src_install

	# This wrapper is not useful when called directly.
	rm "${D}/usr/bin/pwrapper"

	if use doc; then
		dohtml -r doc dev-notes
	fi

	dodoc doc/*.rst
	docinto dev-notes
	dodoc dev-notes/*.rst
}

pkg_postinst() {
	einfo "Registering plugins..."
	register_plugin.py -s fs_ops copyfile 1 pkgcore.fs.ops.default_copyfile
	register_plugin.py -s fs_ops ensure_perms 1 \
		pkgcore.fs.ops.default_ensure_perms
	register_plugin.py -s fs_ops mkdir 1 pkgcore.fs.ops.default_mkdir
	register_plugin.py -s fs_ops merge_contents 1 \
		pkgcore.fs.ops.merge_contents
	register_plugin.py -s fs_ops unmerge_contents 1 \
		pkgcore.fs.ops.unmerge_contents
	register_plugin.py -s format ebuild_built 0.0 \
		pkgcore.ebuild.ebuild_built.generate_new_factory
	register_plugin.py -s format ebuild_src 0.0 \
		pkgcore.ebuild.ebuild_src.generate_new_factory
}

src_test() {
	"${python}" setup.py build_ext --force --inplace || \
		die "failed building extensions in src dir for testing"
	"${python}" ./sandbox/test.py || die "tested returned non zero"
}
