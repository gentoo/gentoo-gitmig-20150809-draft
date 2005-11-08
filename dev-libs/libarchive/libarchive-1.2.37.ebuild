# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libarchive/libarchive-1.2.37.ebuild,v 1.2 2005/11/08 12:59:48 flameeyes Exp $

inherit eutils

DESCRIPTION="Library to create and read several different archive formats."
HOMEPAGE="http://people.freebsd.org/~kientzle/libarchive/"
SRC_URI="http://people.freebsd.org/~kientzle/libarchive/src/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc-macos ~x86"
IUSE=""

DEPEND="app-arch/bzip2
	sys-libs/zlib"

src_install() {
	make DESTDIR="${D}" install
}

