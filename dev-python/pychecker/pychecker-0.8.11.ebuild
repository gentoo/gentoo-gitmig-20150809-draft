# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pychecker/pychecker-0.8.11.ebuild,v 1.8 2003/04/23 15:25:26 vapier Exp $

inherit distutils

DESCRIPTION="tool for finding common bugs in python source code"
SRC_URI="mirror://sourceforge/pychecker/${P}.tar.gz"
HOMEPAGE="http://pychecker.sourceforge.net/"

SLOT="0"
KEYWORDS="x86 sparc alpha"
LICENSE="BSD"

DEPEND="virtual/python"

src_install() {
	mydoc="pycheckrc TODO"
	distutils_src_install
}
