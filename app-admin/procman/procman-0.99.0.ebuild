# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/procman/procman-0.99.0.ebuild,v 1.4 2002/07/17 20:43:17 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Process viewer for GNOME"
SRC_URI="http://www.personal.psu.edu/users/k/f/kfv101/${PN}/source/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://www.personal.psu.edu/kfv101/procman"
LICENSE="GPL-2"

DEPEND="nls? ( sys-devel/gettext )
        >=gnome-extra/gal-0.13-r1
	>=gnome-base/libgtop-1.0.12-r1"

src_compile() {
	local myconf

	if [ -z "`use nls`" ] ; then
		myconf="--disable-nls"
	fi

	CFLAGS="$CFLAGS `gdk-pixbuf-config --cflags`"

	./configure --host=${CHOST} 					\
		    --prefix=/usr					\
		    --sysconfdir=/etc					\
		    --localstatedir=/var/lib				\
		    --disable-more-warnings				\
		    $myconf || die

	emake || die
}

src_install () {
	make prefix=${D}/usr						\
	     sysconfdir=${D}/etc					\
	     localstatedir=${D}/var/lib					\
	     install || die

	dodoc AUTHORS COPYING ChangeLog README NEWS TODO
}
