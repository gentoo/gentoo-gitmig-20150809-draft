# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/arts/arts-1.0.1.20020604.ebuild,v 1.1 2002/06/05 19:14:09 danarmak Exp $

inherit kde-patch kde-base kde.org

SRC_URI="$SRC_URI ftp://ftp.kde.org/pub/kde/stable/3.0.1/src/${P}.tar.bz2"
DESCRIPTION="KDE 3.x Sound Server"
set-kdedir 3
need-qt 3.0.3

SLOT="1"

use alsa && myconf="$myconf --enable-alsa" || myconf="$myconf --disable-alsa"

src_unpack() {
    
    base_src_unpack
    
    kde_sandbox_patch ${S}/soundserver

}

src_install() {

    kde_src_install
    dodoc ${S}/doc/{NEWS,README,TODO}

}
