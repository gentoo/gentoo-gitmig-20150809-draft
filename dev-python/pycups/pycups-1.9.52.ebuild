# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycups/pycups-1.9.52.ebuild,v 1.1 2010/11/03 19:12:55 reavertm Exp $

EAPI="2"

RESTRICT_PYTHON_ABIS="3.*"
SUPPORT_PYTHON_ABIS="1"
inherit distutils flag-o-matic

DESCRIPTION="Python bindings for the CUPS API"
HOMEPAGE="http://cyberelk.net/tim/data/pycups/"
SRC_URI="http://cyberelk.net/tim/data/pycups/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"
SLOT="0"
IUSE="doc examples"

RDEPEND="
	>=net-print/cups-1.4.4
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
