# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/reiserfsprogs/reiserfsprogs-3.6.8.ebuild,v 1.1 2003/05/21 00:36:44 lostlogic Exp $

inherit flag-o-matic eutils

filter-flags -fPIC

S=${WORKDIR}/${P}
DESCRIPTION="Reiserfs Utilities"
SRC_URI="http://www.namesys.com/pub/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.namesys.com"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND="virtual/glibc"

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

