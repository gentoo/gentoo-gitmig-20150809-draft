# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: tools@cvs.gentoo.org
# $Header: /var/cvsroot/gentoo-x86/dev-python/pychecker/pychecker-0.8.2.ebuild,v 1.1 2001/08/16 04:09:28 chadh Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="PyChecker is a tool for finding common bugs in python source code."
SRC_URI="http://prdownloads.sourceforge.net/pychecker"/${A}
HOMEPAGE="http://pychecker.sourceforge.net/"

DEPEND="virtual/python"

src_install(){
    try python setup.py install --prefix=${D}/usr
    dodoc CHANGELOG
    dodoc COPYRIGHT
    dodoc KNOWN_BUGS
    dodoc MAINTAINERS
    dodoc README
    dodoc TODO
    dodoc VERSION
}
