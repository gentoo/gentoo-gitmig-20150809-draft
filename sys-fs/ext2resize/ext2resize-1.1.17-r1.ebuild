# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/ext2resize/ext2resize-1.1.17-r1.ebuild,v 1.2 2004/01/13 00:28:26 agriffis Exp $

IUSE="static"

DESCRIPTION="EXT2 and EXT3 filesystem resizing utilities"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://ext2resize.sourceforge.net/"
KEYWORDS="x86 amd64 ~ppc ~sparc alpha"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"

src_compile() {
	if [ "`use static`" ]; then
		LDFLAGS="${LDFLAGS} -static"
	fi

	econf --exec-prefix="${D}/"|| die "Configure failed"

	emake LDFLAGS="${LDFLAGS}"|| die "Make failed"
}

src_install() {
	einstall || die "Install failed"
	dodir /usr/sbin
	dosym /sbin/ext2online /usr/sbin/ext2online
	dosym /sbin/ext2prepare /usr/sbin/ext2prepare
	dosym /sbin/ext2resize /usr/sbin/ext2resize

}
