# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mikael Hallendal <hallski@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/procman/procman-0.10.3.ebuild,v 1.2 2001/10/06 22:47:06 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Process viewer for GNOME"
SRC_URI="http://www.personal.psu.edu/users/k/f/kfv101/procman/source/${A}"
HOMEPAGE="http://www.personal.psu.edu/kfv101/procman"

DEPEND="nls? ( sys-devel/gettext )
        >=gnome-extra/gal-0.13-r1
	>=gnome-base/libgtop-1.0.12-r1"

src_compile() {
	local myconf

	if [ -z "`use nls`" ] ; then
		myconf="--disable-nls"
	fi

	./configure --host=${CHOST} 					\
		    --prefix=/usr					\
		    --sysconfdir=/etc					\
		    --disable-more-warnings				\
		    $myconf || die

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog README NEWS TODO
}
