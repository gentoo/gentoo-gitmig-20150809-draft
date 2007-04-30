# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/workingenv/workingenv-0.6.5.ebuild,v 1.3 2007/04/30 20:33:03 genone Exp $

inherit distutils

MY_PN="${PN}.py"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Tool to create an isolated Python environment."
HOMEPAGE="http://cheeseshop.python.org/pypi/workingenv.py"
SRC_URI="http://cheeseshop.python.org/packages/source/w/${MY_PN}/${MY_P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
S=${WORKDIR}/${MY_P}

pkg_postinst() {
	elog "Quickstart:"
	elog ""
	elog "workingenv <directory name>"
	elog "source <directory name>/bin/activate"
	elog ""
	elog "You are now working in a sandboxed Python environment."
	elog "Any packages installed with distutils/easy_install/setuptools"
	elog "will be installed in <directory name>/lib"
	elog "Note: <directory name> will be created."
}
