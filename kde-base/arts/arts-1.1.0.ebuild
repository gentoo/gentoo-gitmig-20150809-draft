# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/arts/arts-1.1.0.ebuild,v 1.16 2003/02/28 20:44:51 wwoods Exp $
inherit kde-base flag-o-matic

# this is the arts 1.1 from kde 3.1, as opposed to arts 1.1.0 from kde 3.1 beta2 and friends

IUSE="alsa"
S=$WORKDIR/$PN-1.1
SRC_URI="mirror://gentoo/arts-1.1_kde-3.1.tar.bz2"
KEYWORDS="x86 ppc sparc ~alpha"
HOMEPAGE="http://multimedia.kde.org"
DESCRIPTION="aRts, the KDE sound (and all-around multimedia) server/output manager"
set-kdedir 3.1
need-qt 3.1.0

if [ "${COMPILER}" == "gcc3" ]; then
	# GCC 3.1 kinda makes arts buggy and prone to crashes when compiled with 
	# these.. Even starting a compile shuts down the arts server
	filter-flags "-fomit-frame-pointer -fstrength-reduce"
fi

#fix bug 13453
filter-flags "-foptimize-sibling-calls"

SLOT="3.1"
LICENSE="GPL-2 LGPL-2"

use alsa && myconf="$myconf --enable-alsa" || myconf="$myconf --disable-alsa"

PATCHES="${FILESDIR}/tmp-mcop-user-fix.patch"

src_unpack() {
	kde_src_unpack
	kde_sandbox_patch ${S}/soundserver
}

src_install() {
	kde_src_install
	dodoc ${S}/doc/{NEWS,README,TODO}
}
