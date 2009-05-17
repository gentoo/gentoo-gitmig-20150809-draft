# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cssutils/cssutils-0.9.6_alpha4.ebuild,v 1.1 2009/05/17 01:31:37 arfrever Exp $

inherit distutils

MY_P=${P/_alpha/a}
DESCRIPTION="A Python package to parse and build CSS Cascading Style Sheets."
HOMEPAGE="http://code.google.com/p/cssutils"
SRC_URI="http://cssutils.googlecode.com/files/${MY_P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="virtual/python"
DEPEND=">=dev-python/setuptools-0.6_rc7-r1
		${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_install() {
	distutils_src_install

	rm -fr "${D}$(python_get_sitedir)/tests"
}
