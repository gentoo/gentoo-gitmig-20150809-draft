# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pkgcore/pkgcore-0.2.1.ebuild,v 1.1 2007/01/24 19:07:13 jokey Exp $

inherit distutils toolchain-funcs

DESCRIPTION="pkgcore package manager"
HOMEPAGE="http://www.pkgcore.org"
SRC_URI="http://www.pkgcore.org/releases/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc64 ~sparc ~x86"
IUSE="doc"

DEPEND=">=dev-lang/python-2.4"
RDEPEND=">=dev-lang/python-2.4
	|| ( >=dev-lang/python-2.5 dev-python/pycrypto )
	>=app-shells/bash-3.0
	doc? ( >=dev-python/docutils-0.4 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	use hppa && epatch "${FILESDIR}/${PN}-0.2-hppa-disable-filter-env.patch"
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
	distutils_pkg_postinst
	echo "updating pkgcore plugin cache"
	pplugincache
}

src_test() {
	"${python}" setup.py build_ext --inplace || \
		die "failed building extensions in src dir for testing"
	"${python}" setup.py test || die "tested returned non zero"
}
