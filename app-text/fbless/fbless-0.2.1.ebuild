# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/fbless/fbless-0.2.1.ebuild,v 1.1 2012/07/13 07:48:38 yngwin Exp $

EAPI=4
PYTHON_COMPAT="python2_7"
inherit python-distutils-ng

DESCRIPTION="Python-based console fb2 reader with less-like interface"
HOMEPAGE="http://pybookreader.narod.ru/misc.html"
SRC_URI="http://pybookreader.narod.ru/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/python:2.7[ncurses,xml]"
RDEPEND="${DEPEND}"
