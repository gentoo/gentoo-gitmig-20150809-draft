# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cppi/cppi-1.16.ebuild,v 1.2 2012/01/26 06:27:40 jer Exp $

EAPI=4

DESCRIPTION="a cpp directive indenter"
HOMEPAGE="http://savannah.gnu.org/projects/cppi"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/xz-utils"

DOCS=( AUTHORS ChangeLog NEWS THANKS TODO )
