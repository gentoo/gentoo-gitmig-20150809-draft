# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/arts/arts-1.0.5a.ebuild,v 1.2 2002/12/21 15:54:27 hannes Exp $
inherit kde-base flag-o-matic

SRC_URI="mirror://kde/stable/3.0.5a/src/${P}.tar.bz2"
KEYWORDS="x86 ppc alpha"
HOMEPAGE="http://multimedia.kde.org"

DESCRIPTION="KDE 3.x Sound Server"
set-kdedir 3
need-qt 3.0.5

if [ "${COMPILER}" == "gcc3" ]; then
    # GCC 3.1 kinda makes arts buggy and prone to crashes when compiled with 
    # these.. Even starting a compile shuts down the arts server
    filter-flags "-fomit-frame-pointer -fstrength-reduce"
fi

SLOT="3.0"
LICENSE="GPL-2 LGPL-2"

# fix bug #10338
PATCHES="${FILESDIR}/tmp-mcop-user-fix.patch"

# fix bug #8175
MAKEOPTS="$MAKEOPTS -j1"

use alsa && myconf="$myconf --enable-alsa" || myconf="$myconf --disable-alsa"

src_unpack() {

    base_src_unpack
    
    kde_sandbox_patch ${S}/soundserver

}

src_install() {

    kde_src_install
    # fix root exploit - fixed upstream already
    #chmod ug-s ${D}${KDEDIR}/bin/artswrapper
    dodoc ${S}/doc/{NEWS,README,TODO}

}
