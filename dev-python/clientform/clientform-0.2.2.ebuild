# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/clientform/clientform-0.2.2.ebuild,v 1.1 2006/03/26 21:40:29 lucass Exp $

inherit distutils

MY_P="ClientForm-${PV}"
DESCRIPTION="Parse, fill out, and return HTML forms on the client side"
HOMEPAGE="http://wwwsearch.sourceforge.net/ClientForm/"
SRC_URI="http://wwwsearch.sourceforge.net/ClientForm/src/${MY_P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

S="${WORKDIR}/${MY_P}"
DOCS="*.txt"

src_unpack() {
	unpack ${A}
	cd ${S}

	# use distutils instead of setuptools
	sed -e 's/not hasattr(sys, "version_info")/1/' -i setup.py
}

src_install() {
	# remove to prevent distutils_src_install from installing it
	dohtml *.html
	rm README.html*

	distutils_src_install

	cp -r examples ${D}/usr/share/doc/${PF}
}
