# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/kde-base/arts/arts-1.0.2.ebuild,v 1.5 2002/07/13 20:52:11 danarmak Exp $
inherit kde-base flag-o-matic

SRC_UR="mirror://kde/stable/3.0.2/src/${P}.tar.bz2"

SRC_URI="ftp://ftp.kde.org/pub/kde/stable/3.0.2/src/${P}.tar.bz2"
DESCRIPTION="KDE 3.x Sound Server"
set-kdedir 3
need-qt 3.0.3

if [ "${COMPILER}" == "gcc3" ]; then
# GCC 3.1 kinda makes arts buggy and prone to crashes when compiled with 
# these.. Even starting a compile shuts down the arts server
filter-flags "-fomit-frame-pointer -fstrength-reduce"

fi

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
