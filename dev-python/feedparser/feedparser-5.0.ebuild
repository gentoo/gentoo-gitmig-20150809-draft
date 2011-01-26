# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/feedparser/feedparser-5.0.ebuild,v 1.1 2011/01/26 12:25:33 sping Exp $

EAPI="2"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"  # See README-PYTHON3 in tarball if you want to work on this

inherit distutils

DESCRIPTION="Parse RSS and Atom feeds in Python"
HOMEPAGE="http://www.feedparser.org/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="test"

DEPEND=""
RDEPEND=""

PYTHON_MODNAME="feedparser.py"
DOCS=( LICENSE NEWS )

src_test() {
	testing() {
		cd feedparser || die
		"$(PYTHON)" ${PN}test.py || die
	}
	python_execute_function testing
}
