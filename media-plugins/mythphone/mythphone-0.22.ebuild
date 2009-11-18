# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythphone/mythphone-0.22.ebuild,v 1.1 2009/11/18 00:31:42 cardoe Exp $

DESCRIPTION="stub build"
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

pkg_postinst() {
	ewarn "This is a stub ebuild for upgrading to 0.22."
	ewarn "Unmerge this package, as it has been removed by upstream MythTV"
}
