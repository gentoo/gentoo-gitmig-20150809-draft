# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pychecker/pychecker-0.8.13.ebuild,v 1.7 2004/08/21 03:38:21 weeve Exp $

inherit distutils

DESCRIPTION="tool for finding common bugs in python source code"
SRC_URI="mirror://sourceforge/pychecker/${P}.tar.gz"
HOMEPAGE="http://pychecker.sourceforge.net/"

SLOT="0"
KEYWORDS="x86 sparc alpha ~ppc"
LICENSE="BSD"
IUSE=""

DEPEND="virtual/python"

mydoc="pycheckrc TODO"
