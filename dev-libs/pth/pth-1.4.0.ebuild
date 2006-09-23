# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pth/pth-1.4.0.ebuild,v 1.27 2006/09/23 00:57:44 dragonheart Exp $

inherit libtool eutils

DESCRIPTION="GNU Portable Threads"
HOMEPAGE="http://www.gnu.org/software/pth/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa mips ppc ppc-macos ppc64 s390 sh sparc x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	use ppc-macos && darwintoolize
	epatch "${FILESDIR}/${P}-sigstack.patch"
	#fix warnings
	sed -i "s:pow10:math_pow10:g" "${S}"/pth_string.c
	sed -i "s:round:math_round:g" "${S}"/pth_string.c
}

src_install() {
	einstall || die
	dodoc ANNOUNCE AUTHORS ChangeLog NEWS README THANKS USERS
}
