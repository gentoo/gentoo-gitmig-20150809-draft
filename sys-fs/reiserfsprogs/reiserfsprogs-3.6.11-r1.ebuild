# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/reiserfsprogs/reiserfsprogs-3.6.11-r1.ebuild,v 1.1 2003/09/23 17:29:11 drobbins Exp $

inherit flag-o-matic eutils

filter-flags -fPIC

S=${WORKDIR}/${P}
DESCRIPTION="Reiserfs Utilities"
SRC_URI="http://www.namesys.com/pub/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.namesys.com"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="ia64"

src_unpack() {
	unpack ${A}
	if [ "$ARCH" = "ia64" ]
	then
		#Should work on everything, but needed on IA-64. Thanks
		#to Vitaly Fertman from the Namesys/ReiserFS team for
		#this fix. Makes reiserfsck work. (drobbins, 23 Sep 03)
		cd ${S}
		cat ${FILESDIR}/blk_size.patch | patch -p2 || die "patch application failure"
	fi
}

src_compile() {
	./configure --prefix=/ || die "Failed to configure"
	emake || die "Failed to compile"
}

src_install() {
	make DESTDIR="${D}" install || die "Failed to install"
	dodir /usr/share
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README

	cd ${D}
	mv man usr/share
	dosym /sbin/reiserfsck /sbin/fsck.reiserfs
}

