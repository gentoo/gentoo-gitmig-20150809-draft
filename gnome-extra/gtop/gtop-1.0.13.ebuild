# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gtop/gtop-1.0.13.ebuild,v 1.5 2001/10/06 23:11:22 hallski Exp $


A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gtop"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}"
HOMEPGAE="http://www.gnome.org/"

DEPEND=">=gnome-base/libgtop-1.0.12-r1
        nls? ( sys-devel/gettext )"

src_compile() {
	local myconf

	if [ -z "`use nls`" ] ; then
		myconf="--disable-nls"
	fi

	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    $myconf || die

	emake || die
}

src_install() {
	make DESTDIR=${D} prefix=${D}/usr install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}

