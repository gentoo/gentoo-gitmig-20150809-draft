# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libreplaygain/libreplaygain-458.ebuild,v 1.2 2010/01/06 18:51:30 ssuominen Exp $

inherit cmake-utils

# svn co http://svn.musepack.net/libreplaygain libreplaygain-${PV}
# find ./libreplaygain-${PV} -type d -name .svn | xargs rm -rf
# tar -cjf libreplaygain-${PV}.tar.bz2 libreplaygain-${PV}

DESCRIPTION="Replay Gain library from Musepack"
HOMEPAGE="http://www.musepack.net"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

src_install() {
	cmake-utils_src_install
	insinto /usr/include
	doins -r include/replaygain || die
}
