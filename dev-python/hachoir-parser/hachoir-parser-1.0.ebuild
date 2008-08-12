# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/hachoir-parser/hachoir-parser-1.0.ebuild,v 1.3 2008/08/12 08:08:07 cedk Exp $

NEED_PYTHON=2.4

inherit distutils

DESCRIPTION="a package of most common file format parsers written using
hachoir-core"
HOMEPAGE="http://hachoir.org/wiki/hachoir-parser"
SRC_URI="http://cheeseshop.python.org/packages/source/h/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=dev-python/hachoir-core-1.0.1"

PYTHON_MODNAME="hachoir_parser"
