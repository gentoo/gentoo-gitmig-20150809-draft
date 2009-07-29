# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libreplaygain/libreplaygain-444.ebuild,v 1.8 2009/07/29 14:29:26 jer Exp $

inherit cmake-utils

# svn co http://svn.musepack.net/libreplaygain libreplaygain-${PV}
# tar -cjf libreplaygain-${PV}.tar.bz2 libreplaygain-${PV}

DESCRIPTION="Replay Gain library from Musepack"
HOMEPAGE="http://www.musepack.net"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86 ~x86-fbsd"
IUSE=""

PATCHES=( "${FILESDIR}/${P}-multilib.patch" )

src_install() {
	cmake-utils_src_install
	insinto /usr/include/replaygain
	doins -r include/replaygain/*.h || die "doins failed"
}
