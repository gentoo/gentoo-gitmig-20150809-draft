# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycups/pycups-1.9.49.ebuild,v 1.4 2010/06/05 22:16:39 reavertm Exp $

EAPI="2"

PYTHON_DEPEND="2:2.5"
RESTRICT_PYTHON_ABIS="2.4 3.*"
SUPPORT_PYTHON_ABIS="1"
inherit distutils flag-o-matic

DESCRIPTION="Python bindings for the CUPS API"
HOMEPAGE="http://cyberelk.net/tim/data/pycups/"
SRC_URI="http://cyberelk.net/tim/data/pycups/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc examples"

RDEPEND="
	net-print/cups
"
DEPEND="${RDEPEND}
	doc? ( dev-python/epydoc )
"

src_compile() {
	append-cflags -DVERSION=\\\"${PV}\\\"
	distutils_src_compile

	if use doc; then
		emake doc || die "emake doc failed"
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r html/ || die "installing html docs failed"
	fi

	if use examples; then
		insinto /usr/share/doc/"${P}"
		doins -r examples/ || die "installing examples failed"
	fi
}
