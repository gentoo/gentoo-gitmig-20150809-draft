# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bzr/bzr-0.6.2.ebuild,v 1.1 2006/01/07 01:20:43 arj Exp $

inherit distutils
MY_P="bzr-${PV}"
PYTHON_MODNAME="bzrlib"
DESCRIPTION="next generation distributed version control"
HOMEPAGE="http://bazaar-ng.org/"
SRC_URI="http://bazaar-ng.org/pkg/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND=">=dev-lang/python-2.4
	dev-python/elementtree"
S="${WORKDIR}/${MY_P}"

pkg_postinst() {
	distutils_pkg_postinst
	einfo "You may optionally \033[1memerge dev-python/celementtree\033[0m for faster processing."
}
