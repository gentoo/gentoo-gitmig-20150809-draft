# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/arts/arts-1.0.0.ebuild,v 1.6 2002/05/21 18:14:08 danarmak Exp $

inherit kde-base kde.org

SRC_URI="ftp://ftp.kde.org/pub/kde/stable/3.0/src/${P}.tar.bz2"
DESCRIPTION="kde: aRts"
set-kdedir 3
need-qt 3.0.3

SLOT="1"

use alsa && myconf="$myconf --enable-alsa" || myconf="$myconf --disable-alsa"

src_unpack() {
    
    base_src_unpack
    
    kde_sandbox_patch ${S}/soundserver

}
