# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/reiserfsprogs/reiserfsprogs-3.6.11.ebuild,v 1.6 2004/01/09 22:03:31 weeve Exp $

inherit flag-o-matic eutils

filter-flags -fPIC

S=${WORKDIR}/${P}
DESCRIPTION="Reiserfs Utilities"
SRC_URI="http://www.namesys.com/pub/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.namesys.com"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="ia64 x86 ~amd64 ~ppc sparc ~alpha ppc64"

src_compile() {
	epatch ${FILESDIR}/${P}-2.6.patch

	./configure --prefix=/ || die "Failed to configure"
	emake || die "Failed to compile"
}

src_install() {
	make DESTDIR="${D}" install || die "Failed to install"
	dodir /usr/share
	dodoc COPYING ChangeLog INSTALL README

	cd ${D}
	mv man usr/share
	dosym /sbin/reiserfsck /sbin/fsck.reiserfs
}

