# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mikael Hallendal <hallski@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/procman/procman-0.10.3.ebuild,v 1.1 2001/10/01 10:52:34 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Process viewer for GNOME"
SRC_URI="http://www.personal.psu.edu/users/k/f/kfv101/procman/source/${A}"
HOMEPAGE="http://www.personal.psu.edu/kfv101/procman"

DEPEND="nls? ( sys-devel/gettext )
        >=gnome-base/gal-0.9.1
	>=gnome-base/libgtop-1.0.6"

src_compile() {
    local myconf
    if [ -z "`use nls`" ] ; then
      myconf="--disable-nls"
    fi

    try ./configure --host=${CHOST} --prefix=/opt/gnome \
	--sysconfdir=/etc/opt/gnome --disable-more-warnings $myconf

    try pmake
}

src_install () {

    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog README NEWS TODO

}





