# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libreplaygain/libreplaygain-458.ebuild,v 1.3 2010/01/09 13:12:38 grobian Exp $

inherit cmake-utils

# svn co http://svn.musepack.net/libreplaygain libreplaygain-${PV}
# find ./libreplaygain-${PV} -type d -name .svn | xargs rm -rf
# tar -cjf libreplaygain-${PV}.tar.bz2 libreplaygain-${PV}

DESCRIPTION="Replay Gain library from Musepack"
HOMEPAGE="http://www.musepack.net"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~x86 ~x86-fbsd ~amd64-linux ~ppc-macos"
IUSE=""

src_install() {
	cmake-utils_src_install
	insinto /usr/include
	doins -r include/replaygain || die

	# cmake seems to think it is installing an application bundle, which is
	# wrong, but I can't seem to figure out how to fix it, so I use a laymans
	# approach instead
	if [[ ${CHOST} == *-darwin* ]] ; then
		install_name_tool \
			-id "${EPREFIX}"/usr/$(get_libdir)/libreplaygain.1.dylib \
			"${D%/}${EPREFIX}"/usr/$(get_libdir)/libreplaygain.1.0.0.dylib || die
	fi
}
