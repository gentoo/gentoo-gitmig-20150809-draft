# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/basemap-data/basemap-data-0.9.6.ebuild,v 1.1 2007/11/03 19:09:01 bicatali Exp $

DESCRIPTION="Data for matplotlib basemap toolkit"
HOMEPAGE="http://matplotlib.sourceforge.net/matplotlib.toolkits.basemap.basemap.html"
SRC_URI="mirror://sourceforge/matplotlib/${PN}-hires-${PV}.tar.gz"

RESTRICT="test"

IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
DEPEND=""
RDEPEND=">=dev-python/basemap-${PV}"

S="${WORKDIR}"

src_compile() {
	einfo "nothing to compile"
}

src_install() {
	insinto /usr/share/basemap
	doins *.txt || die
}
