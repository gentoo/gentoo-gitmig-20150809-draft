# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/arts/arts-1.0.0.ebuild,v 1.4 2002/04/03 23:44:45 verwilst Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base kde.org

SRC_URI="ftp://ftp.kde.org/pub/kde/stable/3.0/src/${P}.tar.bz2"
DESCRIPTION="kde: aRts"
set-kdedir 3
need-qt 3.0.3

use alsa && myconf="$myconf --enable-alsa" || myconf="$myconf --disable-alsa"

src_unpack() {
    
    base_src_unpack
    
    kde_sandbox_patch ${S}/soundserver

}
