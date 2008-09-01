# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyxattr/pyxattr-0.4.0.ebuild,v 1.1 2008/09/01 21:44:27 hawking Exp $

inherit distutils

DESCRIPTION="Python interface to xattr"
HOMEPAGE="http://sourceforge.net/projects/pyxattr/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE=""

DEPEND="virtual/python
		sys-apps/attr"
RDEPEND="${DEPEND}"
