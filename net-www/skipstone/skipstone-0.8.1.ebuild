# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Damon Conway <damon@3jane.net> 
# $Header: /var/cvsroot/gentoo-x86/net-www/skipstone/skipstone-0.8.1.ebuild,v 1.2 2002/04/18 12:41:25 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GTK+ based web browser based on the Mozilla engine"
SRC_URI="http://www.muhri.net/skipstone/${P}.tar.gz"
HOMEPAGE="http://www.muhri.net/skipstone/"

DEPEND="nls? ( sys-devel/gettext )
	=net-www/mozilla-0.9.9*
	>=x11-libs/gtk+-1.2.10"

use nls && myconf="enable_nls=1"

src_compile() {
	
	use nls && ( \
		cd ${S}/src
		xgettext -k_ -kN_  ../src/*.[ch]  -o ../locale/skipstone.pot
	)

    cd ${S}/src
    emake	\
		${myconf}	\
		PREFIX="/usr/lib/mozilla" || die
}

src_install () {
    make 	\
		PREFIX=${D}/usr	\
		LOCALEDIR=${D}/usr/share/locale	\
		${myconf} install || die

    dodoc AUTHORS COPYING README README.copying 
}
