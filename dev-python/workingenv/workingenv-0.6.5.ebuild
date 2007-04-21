# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/workingenv/workingenv-0.6.5.ebuild,v 1.2 2007/04/21 23:39:19 pythonhead Exp $

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
	einfo "Quickstart:"
	einfo ""
	einfo "workingenv <directory name>"
	einfo "source <directory name>/bin/activate"
	einfo ""
	einfo "You are now working in a sandboxed Python environment."
	einfo "Any packages installed with distutils/easy_install/setuptools"
	einfo "will be installed in <directory name>/lib"
	einfo "Note: <directory name> will be created."
}
