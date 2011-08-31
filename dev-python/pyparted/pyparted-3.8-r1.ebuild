# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyparted/pyparted-3.8-r1.ebuild,v 1.2 2011/08/31 15:22:30 jer Exp $

EAPI="3"
PYTHON_DEPEND="2:2.7"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"
PYTHON_MODNAME="parted"

inherit distutils

DESCRIPTION="Python bindings for sys-block/parted"
HOMEPAGE="https://fedorahosted.org/pyparted/"
SRC_URI="https://fedorahosted.org/releases/p/y/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="test"

CDEPEND="
	dev-python/decorator
	>=sys-block/parted-3
	sys-libs/ncurses
"
DEPEND="
	${CDEPEND}
	test? ( dev-python/pychecker )
"
RDEPEND="${CDEPEND}"
