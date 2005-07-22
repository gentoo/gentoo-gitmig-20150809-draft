# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libarchive/libarchive-1.02.027.ebuild,v 1.3 2005/07/22 22:40:39 flameeyes Exp $

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

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-osx.patch
}

src_install() {
	make DESTDIR="${D}" install
}

