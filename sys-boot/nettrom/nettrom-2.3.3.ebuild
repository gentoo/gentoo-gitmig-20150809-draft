# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/nettrom/nettrom-2.3.3.ebuild,v 1.4 2004/04/21 04:35:25 mr_bones_ Exp $

DESCRIPTION="NetWinder ARM bootloader and utilities"
HOMEPAGE="http://www.netwinder.org/"
SRC_URI="http://gentoo.superlucidity.net/arm/netwinder/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-*"
IUSE=""

DEPEND="virtual/glibc"

src_unpack() {
	echo
}

src_install() {
	cd ${D}
	unpack ${P}.tar.gz
}
