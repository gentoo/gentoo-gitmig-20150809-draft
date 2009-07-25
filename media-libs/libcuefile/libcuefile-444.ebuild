# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libcuefile/libcuefile-444.ebuild,v 1.1 2009/07/25 13:25:39 ssuominen Exp $

inherit cmake-utils

# svn co http://svn.musepack.net/libcuefile/trunk libcuefile-${PV}
# tar -cjf libcuefile-${PV}.tar.bz2 libcuefile-${PV}

DESCRIPTION="Cue File library from Musepack"
HOMEPAGE="http://www.musepack.net"
SRC_URI="http://dev.gentoo.org/~ssuominen/${P}.tar.bz2
	mirror://gentoo/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

PATCHES=( "${FILESDIR}/${P}-multilib_and_shared.patch" )

src_install() {
	cmake-utils_src_install
	insinto /usr/include/cuetools
	doins include/cuetools/*.h || die "doins failed"
}
