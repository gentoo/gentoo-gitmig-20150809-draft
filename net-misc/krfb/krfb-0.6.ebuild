# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/krfb/krfb-0.6.ebuild,v 1.14 2003/04/23 13:46:41 danarmak Exp $

inherit kde-base

LICENSE="GPL-2"
need-kde 3
DESCRIPTION="KDE Desktop Sharing Application (vnc protocol). Warning: included in >=kdenetwork-3.1!"
SRC_URI="http://www.tjansen.de/krfb/${P}.tar.bz2"
HOMEPAGE="http://www.tjansen.de/krfb/"
KEYWORDS="x86 sparc "

src_install() {
	dodir /${PREFIX}/share/apps/krfb
	make DESTDIR=${D} install || die
}

warning_msg() {

eerror "WARNING: this app is now part of kdenetwork-3.1. It is very much recommended that you"
eerror "upgrade to kde 3.1 instead of using this standalone app, because it is no longer being"
eerror "updated or fixed."
sleep 5

}

pkg_setup() {
    warning_msg
}

pkg_postinst() {
    warning_msg
}
