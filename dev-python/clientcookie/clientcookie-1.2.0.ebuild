# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/clientcookie/clientcookie-1.2.0.ebuild,v 1.1 2006/03/29 15:12:10 lucass Exp $

inherit distutils

MY_P="ClientCookie-${PV}"
DESCRIPTION="Python module for handling HTTP cookies on the client side"
HOMEPAGE="http://wwwsearch.sourceforge.net/ClientCookie/"
SRC_URI="http://wwwsearch.sourceforge.net/ClientCookie/src/${MY_P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~ppc ~x86"
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
}
