# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pychecker/pychecker-0.8.11.ebuild,v 1.6 2002/12/15 10:44:18 bjb Exp $

S=${WORKDIR}/${P}
DESCRIPTION="PyChecker is a tool for finding common bugs in python source code."
SRC_URI="mirror://sourceforge/pychecker/${P}.tar.gz"
HOMEPAGE="http://pychecker.sourceforge.net/"

DEPEND="virtual/python"

SLOT="0"
KEYWORDS="x86 sparc alpha"
LICENSE="BSD"

inherit distutils

src_install(){
	mydoc="pycheckrc TODO"
	distutils_src_install
}

