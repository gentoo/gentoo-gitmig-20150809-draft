# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Damon Conway <damon@3jane.net> 
# $Header: /var/cvsroot/gentoo-x86/net-www/skipstone/skipstone-0.8.0.ebuild,v 1.2 2002/03/27 23:40:15 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GTK+ based web browser based on the Mozilla engine"
SRC_URI="http://www.muhri.net/skipstone/${P}.tar.gz"
HOMEPAGE="http://www.muhri.net/skipstone/"

DEPEND="nls? ( sys-devel/gettext )
	~net-www/mozilla-0.9.9
	>=x11-libs/gtk+-1.2.10"

src_compile() {
    local myconf

	use nls && myconf="enable_nls=1"

    cd ${S}/src
    emake $myconf CFLAGS="-g -Wall ${CFLAGS}" PREFIX="/usr/lib/mozilla" || die
}

src_install () {
    make PREFIX=${D}/usr install || die
    dodoc AUTHORS COPYING README README.copying 
}
