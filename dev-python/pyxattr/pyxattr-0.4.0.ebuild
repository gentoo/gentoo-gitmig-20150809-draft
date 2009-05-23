# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyxattr/pyxattr-0.4.0.ebuild,v 1.5 2009/05/23 12:27:57 maekke Exp $

inherit distutils

DESCRIPTION="Python interface to xattr"
HOMEPAGE="http://sourceforge.net/projects/pyxattr/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~arm ~ia64 ppc ppc64 ~sh ~sparc x86"
IUSE=""

RDEPEND="virtual/python
		sys-apps/attr"
DEPEND="${RDEPEND}
		>=dev-python/setuptools-0.6_rc7-r1"
