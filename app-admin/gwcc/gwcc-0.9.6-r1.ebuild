# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/gwcc/gwcc-0.9.6-r1.ebuild,v 1.6 2002/07/17 20:43:16 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GNOME Workstation Command Center"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://gwcc.sourceforge.net"
LICENSE="GPL-2"

DEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1
	nls? ( sys-devel/gettext )"
	
RDEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1
	 sys-apps/net-tools"

src_compile() {
    local myconf

    if [ "`use nls`" ] ; then
	myconf="--disable-nls"
    fi

    ./configure --prefix=/usr --host=${CHOST} ${myconf} || die
    
    make || die
}

src_install () {
    make DESTDIR=${D} install || die

    dodoc COPYING ChangeLog NEWS README 
}

