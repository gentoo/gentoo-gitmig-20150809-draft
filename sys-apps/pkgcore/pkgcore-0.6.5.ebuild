# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pkgcore/pkgcore-0.6.5.ebuild,v 1.2 2011/06/24 19:38:57 ferringb Exp $

EAPI="3"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

DESCRIPTION="pkgcore package manager"
HOMEPAGE="http://www.pkgcore.org"
SRC_URI="http://www.pkgcore.org/releases/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="doc"

RDEPEND=">=dev-lang/python-2.4
	>=dev-python/snakeoil-0.4.1
	dev-python/pyparsing
	|| ( >=dev-lang/python-2.5 dev-python/pycrypto )"
DEPEND="${RDEPEND}
	doc? ( >=dev-python/docutils-0.4 )"

DOCS="AUTHORS NEWS"

pkg_setup() {
	# disable snakeoil 2to3 caching...
	unset PY2TO3_CACHEDIR
	python_pkg_setup
}

src_compile() {
	distutils_src_compile

	if use doc; then
		./build_docs.py || die "doc building failed"
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r doc dev-notes
		doman man/*.1
	fi

	dodoc doc/*.rst man/*.rst
	docinto dev-notes
	dodoc dev-notes/*.rst
}

pkg_postinst() {
	distutils_pkg_postinst
	pplugincache

	if [[ -d "${ROOT}etc/pkgcore/plugins" ]]; then
		elog "You still have an /etc/pkgcore/plugins from pkgcore 0.1."
		elog "It is unused by pkgcore >= 0.2, remove it now."
		die "remove /etc/pkgcore/plugins from pkgcore 0.1"
	fi

	# This is left behind by pkgcore 0.2.
	rm -f "${ROOT}"$(python_get_sitedir)/pkgcore/plugins/plugincache
}

pkg_postrm() {
	# Careful not to remove this on up/downgrades.
	local sitep="${ROOT}"$(python_get_sitedir)/site-packages
	if [[ -e "${sitep}/pkgcore/plugins/plugincache2" ]] &&
		! [[ -e "${sitep}/pkgcore/plugin.py" ]]; then
		rm "${sitep}/pkgcore/plugins/plugincache2"
	fi
	distutils_pkg_postrm
}
