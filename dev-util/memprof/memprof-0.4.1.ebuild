# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mikael Hallendal <hallski@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/memprof/memprof-0.4.1.ebuild,v 1.2 2001/10/06 23:03:02 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="MemProf - Profiling and leak detection"
SRC_URI="http://people.redhat.com/otaylor/memprof/${A}"
HOMEPAGE="http://people.redhat.com/otaylor/memprof/"

DEPEND="nls? ( sys-devel/gettext )
	gnome-base/gnome-libs-1.4.1.2-r1
	sys-devel/binutils
	>=gnome-base/libglade-0.17-r1"

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
