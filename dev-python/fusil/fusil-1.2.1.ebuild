# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/fusil/fusil-1.2.1.ebuild,v 1.1 2009/02/28 19:40:44 patrick Exp $

NEED_PYTHON=2.4

inherit distutils

DESCRIPTION="Fusil the fuzzer is a Python library used to write fuzzing programs."
HOMEPAGE="http://fusil.hachoir.org/"
SRC_URI="http://pypi.python.org/packages/source/f/fusil/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="|| ( ( =dev-lang/python-2.4* dev-python/ctypes ) >=dev-lang/python-2.5 )"
RDEPEND="dev-python/python-ptrace"

PYTHON_MODNAME="fusil"

pkg_postinst() {
	enewgroup fusil
	enewuser fusil -1 -1 -1 "fusil"
}
