# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/hachoir-core/hachoir-core-1.1.ebuild,v 1.2 2008/04/04 20:41:56 cedk Exp $

NEED_PYTHON=2.4

inherit distutils

DESCRIPTION="tool written for hackers to cut file or any binary stream"
HOMEPAGE="http://hachoir.org/wiki/hachoir-core"
SRC_URI="http://cheeseshop.python.org/packages/source/h/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

PYTHON_MODNAME="hachoir_core"
