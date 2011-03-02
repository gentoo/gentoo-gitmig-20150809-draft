# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/galaxy/galaxy-1.8.ebuild,v 1.2 2011/03/02 21:35:23 jlec Exp $

EAPI="1"

inherit base toolchain-funcs

DESCRIPTION="stellar simulation program"
HOMEPAGE="http://kornelix.squarespace.com/galaxy/"
SRC_URI="http://kornelix.squarespace.com/storage/downloads/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/gtk+:2"
RDEPEND="${DEPEND}
	x11-misc/xdg-utils"

PATCHES=( "${FILESDIR}/${P}-gentoo.patch" )
DOCS=( "doc/CHANGES" "doc/README" )

pkg_setup() {
	tc-export CXX
}
