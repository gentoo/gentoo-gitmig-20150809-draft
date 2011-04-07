# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/qmtest/qmtest-2.4.1.ebuild,v 1.4 2011/04/07 19:34:23 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit distutils

DESCRIPTION="CodeSourcery's test harness system"
HOMEPAGE="http://www.codesourcery.com/qmtest/"
SRC_URI="http://www.codesourcery.com/public/${PN}/${PF}/${PF}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~mips x86"
IUSE=""

DEPEND=""
RDEPEND=""

PYTHON_MODNAME="qm"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_install() {
	distutils_src_install
	find "${D}" -name config.py -print0 | xargs -0 sed -i "s:${D}:/usr:"
}
