# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-ptrace/python-ptrace-0.5.ebuild,v 1.1 2009/02/03 23:15:34 patrick Exp $

NEED_PYTHON=2.4

inherit distutils

DESCRIPTION="python-ptrace is a debugger using ptrace (Linux, BSD and Darwin system call to trace processes)."
HOMEPAGE="http://python-ptrace.hachoir.org/"
SRC_URI="http://pypi.python.org/packages/source/p/python-ptrace/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="|| ( ( =dev-lang/python-2.4* dev-python/ctypes ) >=dev-lang/python-2.5 )"
RDEPEND="dev-libs/distorm64"

PYTHON_MODNAME="ptrace"
