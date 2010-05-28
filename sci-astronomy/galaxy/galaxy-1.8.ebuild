# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/galaxy/galaxy-1.8.ebuild,v 1.1 2010/05/28 06:42:42 xarthisius Exp $

inherit base toolchain-funcs

DESCRIPTION="stellar simulation program"
HOMEPAGE="http://kornelix.squarespace.com/galaxy/"
SRC_URI="http://kornelix.squarespace.com/storage/downloads/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/gtk+"
RDEPEND="${DEPEND}
	x11-misc/xdg-utils"

PATCHES=( "${FILESDIR}/${P}-gentoo.patch" )
DOCS=( "doc/CHANGES" "doc/README" )

pkg_setup() {
	tc-export CXX
}
