# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pychecker/pychecker-0.8.13.ebuild,v 1.3 2004/05/24 21:39:47 dholm Exp $

inherit distutils

DESCRIPTION="tool for finding common bugs in python source code"
SRC_URI="mirror://sourceforge/pychecker/${P}.tar.gz"
HOMEPAGE="http://pychecker.sourceforge.net/"

SLOT="0"
KEYWORDS="~x86 ~sparc ~alpha ~ppc"
LICENSE="BSD"
IUSE=""

DEPEND="virtual/python"

mydoc="pycheckrc TODO"
