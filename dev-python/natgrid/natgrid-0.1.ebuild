# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/natgrid/natgrid-0.1.ebuild,v 1.1 2008/10/27 15:54:28 bicatali Exp $

inherit distutils

DESCRIPTION="Matplotlib toolkit for gridding irreguraly spaced data"
HOMEPAGE="http://matplotlib.sourceforge.net/users/toolkits.html"
SRC_URI="mirror://sourceforge/matplotlib/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
RDEPEND="dev-python/matplotlib"

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}
	doins test.py || die
}
