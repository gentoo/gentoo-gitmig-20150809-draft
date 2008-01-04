# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/basemap-data/basemap-data-0.9.7.ebuild,v 1.1 2008/01/04 18:35:52 bicatali Exp $

inherit distutils

MYP="${PN}-fullres-${PV}"

DESCRIPTION="Data for matplotlib basemap toolkit"
HOMEPAGE="http://matplotlib.sourceforge.net/matplotlib.toolkits.basemap.basemap.html"
SRC_URI="mirror://sourceforge/matplotlib/${MYP}.tar.gz"

RESTRICT="test"

IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
DEPEND=""
RDEPEND=">=dev-python/basemap-${PV}"

S="${WORKDIR}/${MYP}"

src_compile() {
	einfo "nothing to compile"
}

src_install() {
	${python} setup-data.py install --root="${D}" || die
}
