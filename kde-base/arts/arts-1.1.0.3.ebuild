# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/arts/arts-1.1.0.3.ebuild,v 1.1 2002/11/12 20:03:07 hannes Exp $
inherit kde-base flag-o-matic

# this is the arts 1.1.0 from kde 3.1 rc3, as opposed to the arts 1.1.0 from kde 3.1 beta2

S=$WORKDIR/$PN-1.1.0
SRC_URI="http://user.cs.tu-berlin.de/~mehnert/arts-1.1.0-kde31rc3.tar.bz2"
KEYWORDS="x86"
HOMEPAGE="http://multimedia.kde.org"
DESCRIPTION="KDE Sound Server"
set-kdedir 3.1_rc1
need-qt 3.1.0_pre20021104

if [ "${COMPILER}" == "gcc3" ]; then
    # GCC 3.1 kinda makes arts buggy and prone to crashes when compiled with 
    # these.. Even starting a compile shuts down the arts server
    filter-flags "-fomit-frame-pointer -fstrength-reduce"
fi

SLOT="3.1"
LICENSE="GPL-2 LGPL-2"

use alsa && myconf="$myconf --enable-alsa" || myconf="$myconf --disable-alsa"

set_enable_final

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
