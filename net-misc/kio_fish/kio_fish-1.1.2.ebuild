# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/kio_fish/kio_fish-1.1.2.ebuild,v 1.12 2003/04/23 13:40:44 danarmak Exp $

inherit kde-base

need-kde 3
newdepend ">=net-misc/openssh-3.1_p1"

DESCRIPTION="a kioslave for KDE 3 that lets you view and manipulate your remote files using SSH. Warning: included in >=kdebase-3.1!"
SRC_URI="http://ich.bin.kein.hoschi.de/fish/${P}.tar.bz2"
HOMEPAGE="http://ich.bin.kein.hoschi.de/fish/"

LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "

warning_msg() {

eerror "WARNING: this app is now part of kdebase-3.1. It is very much recommended that you"
eerror "upgrade to kde 3.1 instead of using this standalone app, because it is no longer being"
eerror "updated or fixed. In addition, it won't even compile on a kde 3.1 system."
sleep 5

}

pkg_setup() {
    warning_msg
}

src_install() {
	dodir /usr/kde/3/share/services
	make DESTDIR=${D} install || die
}

pkg_postinst() {
    warning_msg
}
