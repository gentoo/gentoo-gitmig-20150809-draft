# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pychecker/pychecker-0.8.14.ebuild,v 1.3 2004/10/17 07:59:01 absinthe Exp $

inherit distutils

DESCRIPTION="tool for finding common bugs in python source code"
SRC_URI="mirror://sourceforge/pychecker/${P}.tar.gz"
HOMEPAGE="http://pychecker.sourceforge.net/"
SLOT="0"
KEYWORDS="~x86 ~sparc ~alpha ~ppc ~amd64"
LICENSE="BSD"
IUSE=""
RESTRICT="nomirror"
DEPEND="virtual/python"
DOCS="pycheckrc TODO"

