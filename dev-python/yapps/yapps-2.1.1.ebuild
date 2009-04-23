# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/yapps/yapps-2.1.1.ebuild,v 1.1 2009/04/23 21:40:48 patrick Exp $

NEED_PYTHON=2.2

inherit distutils versionator

MY_P="${PN}$(delete_version_separator '-')"
DESCRIPTION="An easy to use parser generator."
HOMEPAGE="http://theory.stanford.edu/~amitp/yapps/"
SRC_URI="http://www-cs-students.stanford.edu/~amitp/yapps/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND=""
RDEPEND=""

S=${WORKDIR}/Yapps-${PV}

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
