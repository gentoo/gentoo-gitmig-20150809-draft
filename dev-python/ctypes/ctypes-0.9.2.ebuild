# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ctypes/ctypes-0.9.2.ebuild,v 1.2 2005/07/12 11:01:44 dholm Exp $

inherit eutils distutils

DESCRIPTION="Python module allowing to create and manipulate C data types."
HOMEPAGE="http://starship.python.net/crew/theller/ctypes/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""
DEPEND=">=dev-lang/python-2.3.3"

DOCS="README.txt NEWS.txt LICENSE.txt samples/* docs/*"
