# Copyright 1999-2002 Gentoo Technologies, Inc. 
# Distributed under the terms of the GNU General Public License v2 
# $Header: /var/cvsroot/gentoo-x86/net-p2p/qtella/qtella-0.6.1.ebuild,v 1.1 2003/02/25 18:21:19 danarmak Exp $
inherit kde-base 

if [ -n "`use kde`" ]; then
    need-kde 3 
else
    need-qt 3
fi

SRC_URI="mirror://sourceforge/qtella/${P}.tar.gz"
HOMEPAGE="http://www.qtella.net"
DESCRIPTION="Excellent QT/KDE Gnutella Client"

SLOT="3" # why??
LICENSE="GPL-2"
KEYWORDS="~x86"
MAKEOPTS="-j1"

# weird workaround
PATCHES="${FILESDIR}/${P}-nokde.diff"

src_compile() {

        kde_src_compile myconf

	if [ -z "`use kde`" ]; then
	    myconf="$myconf --with-kde=no"
	fi

	kde_src_compile configure make
	#/usr/bin/g++ --version
	
}
