# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/aatm/aatm-0.4.3.1.ebuild,v 1.1 2011/11/26 05:53:02 bicatali Exp $

EAPI=4

DESCRIPTION="Atmospheric Modelling for ALMA Observatory"
HOMEPAGE="http://www.mrao.cam.ac.uk/~bn204/alma/atmomodel.html"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

RDEPEND="dev-libs/boost"
DEPEND="${RDEPEND}"

src_configure() {
	econf $(use_enable static-libs static)
}
