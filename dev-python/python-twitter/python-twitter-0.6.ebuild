# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-twitter/python-twitter-0.6.ebuild,v 1.2 2009/10/23 08:30:25 djc Exp $

inherit distutils

DESCRIPTION="This library provides a pure python interface for the Twitter API"
HOMEPAGE="http://code.google.com/p/python-twitter/"
SRC_URI="http://python-twitter.googlecode.com/files/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="dev-python/simplejson"

pkg_postinst() {
	python_version
	python_mod_optimize $(python_get_sitedir)/python_twitter-${PV}-py${PYVER}.egg/
}

pkg_postrm() {
	python_mod_cleanup
}
