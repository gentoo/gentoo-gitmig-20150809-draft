# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/ext2resize/ext2resize-1.1.17-r1.ebuild,v 1.6 2004/06/04 12:28:14 vapier Exp $

inherit flag-o-matic eutils

DESCRIPTION="EXT2 and EXT3 filesystem resizing utilities"
HOMEPAGE="http://ext2resize.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha arm amd64"
IUSE="static"

DEPEND="virtual/glibc"

src_compile() {
	use static && append-ldflags -static

	econf --exec-prefix="${D}/"|| die "Configure failed"

	# Fix broken source for non-''old'' GCCs
	sed -e 's/printf(__FUNCTION__ \"\\n\");/printf(\"%s\\n\", __FUNCTION__);/g' -i src/*.c
	epatch ${FILESDIR}/${P}-gcc3.3.patch

	emake LDFLAGS="${LDFLAGS}"|| die "Make failed"
}

src_install() {
	einstall || die "Install failed"
	dodir /usr/sbin
	dosym /sbin/ext2online /usr/sbin/ext2online
	dosym /sbin/ext2prepare /usr/sbin/ext2prepare
	dosym /sbin/ext2resize /usr/sbin/ext2resize
}
