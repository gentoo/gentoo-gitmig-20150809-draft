# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/arts/arts-1.1.0_rc5-r1.ebuild,v 1.1 2002/12/17 02:57:16 hannes Exp $
inherit kde-base flag-o-matic

# this is the arts 1.1.0 from kde 3.1rc5, as opposed to arts 1.1.0 from kde 3.1 beta2 and friends

S=$WORKDIR/$PN-1.1
SRC_URI="mirror://gentoo/arts-1.1.0-kde31rc5.tar.bz2"
KEYWORDS="x86 ppc sparc"
HOMEPAGE="http://multimedia.kde.org"
DESCRIPTION="aRts, the KDE sound (and all-around multimedia) server/output manager"
set-kdedir 3.1
need-qt 3.1.0

if [ "${COMPILER}" == "gcc3" ]; then
    # GCC 3.1 kinda makes arts buggy and prone to crashes when compiled with 
    # these.. Even starting a compile shuts down the arts server
    filter-flags "-fomit-frame-pointer -fstrength-reduce"
fi

SLOT="3.1"
LICENSE="GPL-2 LGPL-2"

use alsa && myconf="$myconf --enable-alsa" || myconf="$myconf --disable-alsa"

PATCHES="${FILESDIR}/tmp-mcop-user-fix.patch"

src_unpack() {

    base_src_unpack
    
    kde_sandbox_patch ${S}/soundserver

}

src_install() {

    kde_src_install

    dodoc ${S}/doc/{NEWS,README,TODO}

}
