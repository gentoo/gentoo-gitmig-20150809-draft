# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/lzip/lzip-1.4.ebuild,v 1.4 2010/01/30 18:48:40 armin76 Exp $

inherit eutils toolchain-funcs

DESCRIPTION="lossless data compressor based on the LZMA algorithm"
HOMEPAGE="http://www.nongnu.org/lzip/lzip.html"
SRC_URI="http://download.savannah.gnu.org/releases-noredirect/lzip/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~sparc x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
	epatch "${FILESDIR}"/${P}-headers.patch
	tc-export CC CXX
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS README NEWS ChangeLog
}
