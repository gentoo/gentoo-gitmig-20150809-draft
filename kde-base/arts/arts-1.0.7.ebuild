# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/kde-base/arts/arts-1.0.7.ebuild,v 1.1 2002/08/22 21:13:57 danarmak Exp $
inherit kde-base flag-o-matic

SRC_URI="mirror://kde/unstable/kde-3.1-beta1/src/${P}.tar.bz2"
KEYWORDS="x86"
HOMEPAGE="http://multimedia.kde.org"
DESCRIPTION="KDE Sound Server"
set-kdedir 3.1_beta1
need-qt 3.0.3

if [ "${COMPILER}" == "gcc3" ]; then
    # GCC 3.1 kinda makes arts buggy and prone to crashes when compiled with 
    # these.. Even starting a compile shuts down the arts server
    filter-flags "-fomit-frame-pointer -fstrength-reduce"
fi

SLOT="3.1"
LICENSE="GPL-2 LGPL-2"

use alsa && myconf="$myconf --enable-alsa" || myconf="$myconf --disable-alsa"

src_unpack() {

    base_src_unpack
    
    kde_sandbox_patch ${S}/soundserver

}

src_install() {

    kde_src_install

    # fix root exploit
    # fixed on kde cvs, not needed anymore
    # chmod ug-s ${D}${KDEDIR}/bin/artswrapper

    dodoc ${S}/doc/{NEWS,README,TODO}

}
