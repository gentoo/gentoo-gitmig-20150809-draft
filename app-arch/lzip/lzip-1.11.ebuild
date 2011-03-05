# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/lzip/lzip-1.11.ebuild,v 1.1 2011/03/05 22:55:27 vapier Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="lossless data compressor based on the LZMA algorithm"
HOMEPAGE="http://www.nongnu.org/lzip/lzip.html"
SRC_URI="http://download.savannah.gnu.org/releases-noredirect/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.9-build.patch
	tc-export CC CXX
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS README NEWS ChangeLog
}
