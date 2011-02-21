# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/silvercity/silvercity-0.9.7.ebuild,v 1.9 2011/02/21 13:21:53 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils python

MY_PN="SilverCity"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A lexical analyser for many languages."
HOMEPAGE="http://silvercity.sourceforge.net/"
SRC_URI="mirror://sourceforge/silvercity/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ppc ~ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="${MY_PN}"

src_install() {
	distutils_src_install

	# Remove useless documentation.
	rm "${D}usr/share/doc/${P}/PKG-INFO"*

	# Fix permissions.
	chmod 644 "${D}"usr/$(get_libdir)/python*/site-packages/SilverCity/default.css

	# Fix CR/LF issue.
	find "${D}usr/bin" -iname "*.py" -exec sed -e 's/\r$//' -i \{\} \;

	# Fix path.
	dosed -i 's|#!/usr/home/sweetapp/bin/python|#!/usr/bin/env python|' \
		/usr/bin/cgi-styler-form.py || die "dosed failed"
}
