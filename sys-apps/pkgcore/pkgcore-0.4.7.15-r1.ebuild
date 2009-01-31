# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pkgcore/pkgcore-0.4.7.15-r1.ebuild,v 1.1 2009/01/31 12:30:07 patrick Exp $

inherit distutils eutils base

DESCRIPTION="pkgcore package manager"
HOMEPAGE="http://www.pkgcore.org"
SRC_URI="http://www.pkgcore.org/releases/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

RDEPEND=">=dev-lang/python-2.4
	>=dev-python/snakeoil-0.2
	>=app-shells/bash-3.0
	|| ( >=dev-lang/python-2.5 dev-python/pycrypto )"
DEPEND="${RDEPEND}
	doc? ( >=dev-python/docutils-0.4 )"

DOCS="AUTHORS NEWS"

PATCHES=( "${FILESDIR}/pkgcore-sandbox.patch" )

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
	rm -f "${ROOT}"usr/$(get_libdir)/python${PYVER}/site-packages/pkgcore/plugins/plugincache
}

pkg_postrm() {
	python_version
	# Careful not to remove this on up/downgrades.
	local sitep="${ROOT}"usr/$(get_libdir)/python${PYVER}/site-packages
	if [[ -e "${sitep}/pkgcore/plugins/plugincache2" ]] &&
		! [[ -e "${sitep}/pkgcore/plugin.py" ]]; then
		rm "${sitep}/pkgcore/plugins/plugincache2"
	fi
	distutils_pkg_postrm
}

src_test() {
	"${python}" setup.py test || die "testing returned non zero"
}
