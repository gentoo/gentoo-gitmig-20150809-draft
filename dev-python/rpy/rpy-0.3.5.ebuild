# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rpy/rpy-0.3.5.ebuild,v 1.4 2004/10/18 13:13:04 liquidx Exp $

inherit distutils

DESCRIPTION="RPy is a very simple, yet robust, Python interface to the R Programming Language."
HOMEPAGE="http://rpy.sourceforge.net"
SRC_URI="mirror://sourceforge/rpy/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/python
	dev-lang/R"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -e "s#^r_libs = .*#r_libs = '/usr/lib/R/lib'#" \
		-i ${S}/setup.py
}