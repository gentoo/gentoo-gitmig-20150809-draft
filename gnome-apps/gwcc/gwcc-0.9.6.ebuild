# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/gnome-apps/gwcc/gwcc-0.9.6.ebuild,v 1.1 2001/09/12 04:10:31 blocke Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GNOME Workstation Command Center"
SRC_URI="http://prdownloads.sourceforge.net/${PN}/${A}"
HOMEPAGE="http://gwcc.sourceforge.net"

DEPEND="gnome-base/gnome-libs nls? ( sys-devel/gettext )"
RDEPEND="gnome-base/gnome-libs sys-apps/net-tools"

src_compile() {
    local myconf
    if [ "`use nls`" ] ; then
	myconf="--disable-nls"
    fi
    try ./configure --prefix=/opt/gnome --host=${CHOST} ${myconf}
    try make

}

src_install () {

    try make DESTDIR=${D} install
    mv ${D}/usr/share/gnome ${D}/opt/gnome/share/gnome
    dodoc COPYING ChangeLog NEWS README 
}

