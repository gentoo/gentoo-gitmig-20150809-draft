# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Ollie Rutherfurd <oliver@rutherfurd.net>
# Maintainer: Jon Nelson <jnelson@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-python/pychecker/pychecker-0.8.10-r1.ebuild,v 1.1 2002/04/28 05:03:52 jnelson Exp $

S=${WORKDIR}/${P}
DESCRIPTION="PyChecker is a tool for finding common bugs in python source code."
SRC_URI="http://prdownloads.sourceforge.net/pychecker/${P}.tar.gz"
HOMEPAGE="http://pychecker.sourceforge.net/"

DEPEND="virtual/python"
RDEPEND="${DEPEND}"

src_compile() {
	python setup.py build
}

src_install(){
	python setup.py install --root=${D} || die
	dodoc CHANGELOG COPYRIGHT KNOWN_BUGS MAINTAINERS
	dodoc pycheckrc README TODO 
}

