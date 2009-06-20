# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/openstreetmap-icons/openstreetmap-icons-20090616.ebuild,v 1.1 2009/06/20 19:02:23 tupone Exp $

DESCRIPTION="openstreetmap icons"
HOMEPAGE="http://www.openstreetmap.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

# tar.bz2 generated extracting files from
# http://svn.openstreetmap.org/applications/share/map-icons
src_install() {
	insinto /usr/share/icons/
	doins -r map-icons
}
