# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/hachoir-regex/hachoir-regex-1.0.3.ebuild,v 1.1 2008/04/03 16:06:27 cedk Exp $

NEED_PYTHON=2.4

inherit distutils

DESCRIPTION="regex manipulation Python library"
HOMEPAGE="http://hachoir.org/wiki/hachoir-regex"
SRC_URI="http://cheeseshop.python.org/packages/source/h/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=""

PYTHON_MODNAME="hachoir_regex"
