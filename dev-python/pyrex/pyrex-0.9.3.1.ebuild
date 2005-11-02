# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyrex/pyrex-0.9.3.1.ebuild,v 1.2 2005/11/02 03:21:02 sbriesen Exp $

inherit distutils portability

MY_P="Pyrex-${PV}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="a language for writing Python extension modules"
HOMEPAGE="http://www.cosc.canterbury.ac.nz/~greg/python/Pyrex"
SRC_URI="http://www.cosc.canterbury.ac.nz/~greg/python/Pyrex/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~mips ~ppc ~sparc ~x86 ~ppc64 ~hppa"
IUSE=""

PYTHON_MODNAME="Pyrex"

src_install() {
	DOCS="CHANGES.txt INSTALL.txt ToDo.txt USAGE.txt"
	distutils_src_install

	dohtml -r Doc/*
	cp Doc/primes.c "${D}/usr/share/doc/${PF}/html/"
	treecopy Demos "${D}/usr/share/doc/${PF}"
}
