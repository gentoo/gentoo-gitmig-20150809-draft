# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/smbtatools/smbtatools-1.2.3.ebuild,v 1.1 2011/03/24 09:44:08 dagger Exp $

EAPI="4"
inherit cmake-utils

DESCRIPTION="Tools for configuration and query of SMB Traffic Analyzer"
HOMEPAGE="http://github.com/hhetter/smbtatools"
SRC_URI="http://morelias.org/smbta/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="dev-util/cmake
	>=dev-db/sqlite-3.7
	sys-libs/ncurses"
RDEPEND="net-fs/smbtad"

DOCS="doc/smbta-guide.html doc/gfx/*.png"

src_configure() {
	mycmakeargs="${mycmakeargs} \
		$(cmake-utils_use debug DEBUG)"

	cmake-utils_src_configure
}
