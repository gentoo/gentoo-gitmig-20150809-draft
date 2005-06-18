# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pth/pth-1.4.1.ebuild,v 1.22 2005/06/18 00:42:06 vapier Exp $

inherit gnuconfig

DESCRIPTION="GNU Portable Threads"
HOMEPAGE="http://www.gnu.org/software/pth/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ppc ppc-macos ppc64 s390 sparc x86"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}

	# update GNU config files
	gnuconfig_update
	#fix warnings
	sed -i "s:pow10:math_pow10:g" pth_string.c
	sed -i "s:round:math_round:g" pth_string.c
}

src_install() {
	einstall || die
	dodoc ANNOUNCE AUTHORS ChangeLog NEWS README THANKS USERS
}
