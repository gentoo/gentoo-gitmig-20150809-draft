# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysvg/pysvg-0.1.6.ebuild,v 1.2 2010/02/07 21:05:34 pva Exp $

EAPI="2"

inherit eutils distutils

DESCRIPTION="Python SVG document creation library"
HOMEPAGE="http://codeboje.de/pysvg/"
SRC_URI="http://www.codeboje.de/downloads/${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/pySVG/src"

pkg_postinst() {
	ewarn "If you want to use pysvg to make a profit or in a corporate environment,"
	ewarn "then contact Kerim Mansour <kmansour@web.de>."
	ebeep 6
}
