# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Damon Conway <damon@3jane.net> 
# $Header: /var/cvsroot/gentoo-x86/net-www/skipstone/skipstone-0.8.2.ebuild,v 1.1 2002/05/20 02:11:07 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GTK+ based web browser based on the Mozilla engine"
SRC_URI="http://www.muhri.net/skipstone/${P}.tar.gz"
HOMEPAGE="http://www.muhri.net/skipstone/"

DEPEND=">=net-www/mozilla-0.9.9
	>=x11-libs/gtk+-1.2.10"

RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext )"

src_compile() {

	local myconf
	use nls \
		&& myconf="${myconf} --enable-nls"

	econf ${myconf} || die
	
    emake \
		PREFIX="/usr/lib/mozilla" || die
}

src_install () {

    einstall \
		PREFIX=${D}/usr \
		LOCALEDIR=${D}/usr/share/locale \
	|| die
    dodoc AUTHORS COPYING README README.copying 
}
