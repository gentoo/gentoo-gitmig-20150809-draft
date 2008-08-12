# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/hachoir-subfile/hachoir-subfile-0.5.2.ebuild,v 1.3 2008/08/12 08:12:19 cedk Exp $

NEED_PYTHON=2.4

inherit distutils

DESCRIPTION="a tool based on hachoir-parser to find subfiles in any binary stream"
HOMEPAGE="http://hachoir.org/wiki/hachoir-subfile"
SRC_URI="http://cheeseshop.python.org/packages/source/h/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=dev-python/hachoir-core-1.0.1
	>=dev-python/hachoir-parser-1.0
	>=dev-python/hachoir-regex-1.0.2"

PYTHON_MODNAME="hachoir_subfile"
