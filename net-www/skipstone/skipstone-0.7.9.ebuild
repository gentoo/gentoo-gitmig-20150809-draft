# Copyright 2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Damon Conway <damon@3jane.net> 
# $Header: /var/cvsroot/gentoo-x86/net-www/skipstone/skipstone-0.7.9.ebuild,v 1.2 2002/03/12 17:17:40 tod Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GTK+ based web browser based on the Mozilla engine"
SRC_URI="http://www.muhri.net/skipstone/${P}.tar.gz"
HOMEPAGE="http://www.muhri.net/skipstone/"

DEPEND="nls? ( sys-devel/gettext )
	~net-www/mozilla-0.9.8"

src_compile() {
    local myconf
    if [ "`use nls`" ] ; then
 	myconf="enable_nls=1"
    fi
    cd ${S}/src
    emake $myconf PREFIX="/usr" || die
}

src_install () {
    make PREFIX=${D}/usr install || die
    dodoc AUTHORS COPYING README README.copying 
}
