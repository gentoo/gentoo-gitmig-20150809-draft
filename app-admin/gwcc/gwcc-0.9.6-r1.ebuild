# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/app-admin/gwcc/gwcc-0.9.6-r1.ebuild,v 1.2 2001/10/07 16:51:46 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GNOME Workstation Command Center"
SRC_URI="http://prdownloads.sourceforge.net/${PN}/${P}.tar.gz"
HOMEPAGE="http://gwcc.sourceforge.net"

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

