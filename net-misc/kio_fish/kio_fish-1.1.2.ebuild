# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/kio_fish/kio_fish-1.1.2.ebuild,v 1.6 2002/08/14 12:08:08 murphy Exp $

inherit kde-base || die

need-kde 3
newdepend ">=net-misc/openssh-3.1_p1"
DESCRIPTION="a kioslave for KDE 3 that lets you view and manipulate your remote files using SSH"
SRC_URI="http://ich.bin.kein.hoschi.de/fish/${P}.tar.bz2"
HOMEPAGE="http://ich.bin.kein.hoschi.de/fish/"

LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

src_install() {
	mkdir -p ${D}/usr/kde/3/share/services
	make DESTDIR=${D} install || die
}
