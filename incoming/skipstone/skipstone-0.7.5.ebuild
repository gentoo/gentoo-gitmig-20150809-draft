# Copyright 2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Damon Conway <damon@3jane.net> 
# $Header: /var/cvsroot/gentoo-x86/incoming/skipstone/skipstone-0.7.5.ebuild,v 1.1 2001/08/22 11:44:52 danarmak Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GTK+ based web browser based on the Mozilla engine"
SRC_URI="http://www.muhri.net/skipstone/${A}"
HOMEPAGE="http://www.muhri.net/skipstone/"

DEPEND=">=net-www/mozilla-0.9.3"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/skipstone-0.7.5-config_mk.diff
}

src_compile() {
	local myconf
	if [ -z "`use nls`" ] ; then
		myconf="enable_nls=1"
	fi

	make $myconf || die "Could not compile ${P}"
}

src_install () {
    make prefix=${D}/usr install || die "Could not install ${P}"
	dodir /usr/share/doc/${P}
    dodoc AUTHORS COPYING README README.copying 
}

pkg_postinst() {
	einfo "To run skipstone you must set the following environment"
	einfo "variables to the specified settings."
	einfo "export MOZILLA_FIVE_HOME=/usr/local/lib/mozilla"
	einfo "export LD_LIBRARY_PATH=/usr/local/lib/mozilla:$LD_LIBRARY_PATH"
}
