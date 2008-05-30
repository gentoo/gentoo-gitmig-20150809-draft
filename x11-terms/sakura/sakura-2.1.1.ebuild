# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/sakura/sakura-2.1.1.ebuild,v 1.2 2008/05/30 16:00:46 mr_bones_ Exp $

inherit cmake-utils

DESCRIPTION="sakura is a terminal emulator based on GTK and VTE"
HOMEPAGE="http://www.pleyades.net/david/sakura.php"
SRC_URI="http://www.pleyades.net/david/projects/sakura/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.6
	>=x11-libs/vte-0.11"

# this version is first that contains needed FindPkgConfig
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.4.7"

# cmake-utils variables
DOCS="AUTHORS"
# broken translations installation
CMAKE_IN_SOURCE_BUILD="yes"
