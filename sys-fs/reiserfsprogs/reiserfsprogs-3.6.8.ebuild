# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/reiserfsprogs/reiserfsprogs-3.6.8.ebuild,v 1.3 2004/01/29 22:59:04 vapier Exp $

inherit flag-o-matic

DESCRIPTION="Reiserfs Utilities"
HOMEPAGE="http://www.namesys.com/"
SRC_URI="http://www.namesys.com/pub/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha amd64"

src_compile() {
	filter-flags -fPIC
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
