# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pylint/pylint-0.2.1.ebuild,v 1.3 2003/11/06 01:00:51 liquidx Exp $

inherit distutils

DESCRIPTION="PyLint is a python tool that checks if a module satisfy a coding standard"
SRC_URI="ftp://ftp.logilab.org/pub/pylint/${P}.tar.gz"
HOMEPAGE="http://www.logilab.org/projects/pylint/"

SLOT="0"
KEYWORDS="~x86"
LICENSE="GPL-2"
DEPEND=">=dev-python/optik-1.4
	>=dev-python/logilab-common-0.3.4"

PYTHON_MODNAME="logilab"
DOCS="doc/*"

src_install() {
	distutils_src_install

	# prevent multiple packages owning this dummy package
	python_version
	rm -f ${D}/usr/lib/python${PYVER}/site-packages/logilab/__init__.py
}
