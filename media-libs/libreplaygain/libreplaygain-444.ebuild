# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libreplaygain/libreplaygain-444.ebuild,v 1.2 2009/07/25 12:35:35 ssuominen Exp $

inherit cmake-utils

DESCRIPTION="Replay Gain for Musepack"
HOMEPAGE="http://www.musepack.net"
SRC_URI="http://dev.gentoo.org/~ssuominen/${P}.tar.bz2
	mirror://gentoo/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

PATCHES=( "${FILESDIR}/${P}-multilib.patch" )

src_install() {
	cmake-utils_src_install
	insinto /usr/include/replaygain
	doins -r include/replaygain/*.h || die "doins failed"
}
