# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyxattr/pyxattr-0.2.ebuild,v 1.11 2006/08/17 19:33:39 corsair Exp $

inherit distutils

DESCRIPTION="Python interface to xattr"
HOMEPAGE="http://sourceforge.net/projects/pyxattr/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 arm ia64 ppc ppc64 sh sparc x86"
IUSE=""

DEPEND="virtual/python
		sys-apps/attr"
RDEPEND="${DEPEND}"
