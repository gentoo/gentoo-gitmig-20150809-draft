# Copyright 2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Damon Conway <damon@3jane.net> 
# $Header: /var/cvsroot/gentoo-x86/net-www/skipstone/skipstone-0.7.5.ebuild,v 1.1 2001/09/14 05:30:16 lordjoe Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GTK+ based web browser based on the Mozilla engine"
SRC_URI="http://www.muhri.net/skipstone/${A}"
HOMEPAGE="http://www.muhri.net/skipstone/"

DEPEND="nls? ( sys-devel/gettext )
	>=net-www/mozilla-0.9.3"

src_compile() {
    local myconf
    if [ "`use nls`" ] ; then
 	myconf="enable_nls=1"
    fi
    cd ${S}/src
    mv skipstone.h skipstone.h.bak
    sed skipstone.h.bak -e "s:/usr/share:/usr/X11R6/share:" > skipstone.h
    make $myconf PREFIX="/usr/X11R6" MOZILLA_INCLUDES="-I${MOZILLA_FIVE_HOME}/include -I${MOZILLA_FIVE_HOME}/include/nspr" MOZILLA_LIBS="-L${MOZILLA_FIVE_HOME} -lgtkembedmoz -lplds4 -lplc4 -lnspr4 -lgtksuperwin -lxpcom" || die
}

src_install () {
    make PREFIX=${D}/usr/X11R6 install || die
    dodoc AUTHORS COPYING README README.copying 
}
