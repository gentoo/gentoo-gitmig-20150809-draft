# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pychecker/pychecker-0.8.12.ebuild,v 1.1 2003/04/04 19:11:59 liquidx Exp $

inherit distutils

IUSE=""
DESCRIPTION="PyChecker is a tool for finding common bugs in python source code."
SRC_URI="mirror://sourceforge/pychecker/${P}.tar.gz"
HOMEPAGE="http://pychecker.sourceforge.net/"

DEPEND="virtual/python"

SLOT="0"
KEYWORDS="~x86 ~sparc ~alpha"
LICENSE="BSD"

mydoc="pycheckrc TODO"


