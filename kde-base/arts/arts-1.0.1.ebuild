# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/arts/arts-1.0.1.ebuild,v 1.1 2002/05/13 20:38:53 verwilst Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base kde.org

SRC_URI="ftp://ftp.kde.org/pub/kde/stable/3.0.1/src/${P}.tar.bz2"
DESCRIPTION="KDE 3.x Sound Server"
set-kdedir 3
need-qt 3.0.4

SLOT="1"

use alsa && myconf="$myconf --enable-alsa" || myconf="$myconf --disable-alsa"

src_unpack() {
    
    base_src_unpack
    
    kde_sandbox_patch ${S}/soundserver

}
