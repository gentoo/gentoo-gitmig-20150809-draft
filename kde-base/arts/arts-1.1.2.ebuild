# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/arts/arts-1.1.2.ebuild,v 1.1 2003/05/07 11:05:47 danarmak Exp $
inherit kde-base flag-o-matic

# this is the arts 1.1 from kde 3.1, as opposed to arts 1.1.0 from kde 3.1 beta2 and friends

IUSE="alsa"
SRC_URI="mirror://kde/stable/3.1.1/src/${P}.tar.bz2"
KEYWORDS="x86 ~ppc ~sparc ~alpha"
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

src_unpack() {
	kde_src_unpack
	kde_sandbox_patch ${S}/soundserver
}

src_install() {
	kde_src_install
	dodoc ${S}/doc/{NEWS,README,TODO}

	# moved here from kdelibs so that when arts is installed
	# without kdelibs it's still in the path.
	dodir /etc/env.d
echo "PATH=${PREFIX}/bin
ROOTPATH=${PREFIX}/sbin:${PREFIX}/bin
LDPATH=${PREFIX}/lib
CONFIG_PROTECT=${PREFIX}/share/config" > ${D}/etc/env.d/49kdepaths-3.1.1 # number goes down with version upgrade

	echo "KDEDIR=$PREFIX" > ${D}/etc/env.d/56kdedir-3.1.1 # number goes up with version upgrade

}

pkg_postinst() {

einfo "Run chmod +s ${PREFIX}/bin/artswrapper to let artsd use realtime priority"
einfo "and so avoid possible skips in sound. However, on untrusted systems this"
einfo "creates the possibility of a DoS attack that'll use 100% cpu at realtime"
einfo "priority, and so is off by default. See bug #7883."

}
