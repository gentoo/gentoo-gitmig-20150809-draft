# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/galaxy/galaxy-2.0.ebuild,v 1.1 2011/12/28 12:14:11 xarthisius Exp $

EAPI=4

inherit toolchain-funcs

DESCRIPTION="stellar simulation program"
HOMEPAGE="http://kornelix.squarespace.com/galaxy/"
SRC_URI="http://kornelix.squarespace.com/storage/downloads/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/gtk+:2
	x11-misc/xdg-utils"
RDEPEND="${DEPEND}"

pkg_setup() {
	tc-export CXX
}

src_prepare() {
	sed -e '/DOCDIR/ s/PROGRAM)/&-\$(VERSION)/g' \
		-i Makefile || die
}
