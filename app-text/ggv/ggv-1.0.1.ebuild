# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/ggv/ggv-1.0.1.ebuild,v 1.8 2001/10/06 23:59:41 hallski Exp $


A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Gnome Ghostview"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/"${A}
HOMEPAGE="http://www.gnome.org/"

RDEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1
         bonobo? ( >=gnome-base/bonobo-1.0.9-r1 )"

DEPEND="${RDEPEND}
        nls? ( sys-devel/gettext )"

src_compile() {
	local myconf

	if [ -z "`use nls`" ] ; then
		myconf="--disable-nls"
	fi

	if [ "`use bonobo`" ] ; then
		myconf="$myconf --with-bonobo"
	else
		myconf="$myconf --without-bonobo"
		cp configure configure.orig
		sed -e "s/BONOBO_TRUE/BONOBO_FALSE/" configure.orig > configure
	fi

	CFLAGS="${CFLAGS} `gnome-config --cflags bonobo bonobox`"

	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --sysconfdir=/etc					\
		    $myconf || die

	# bonobo support does not work yet
	emake || die
}

src_install() {
	make prefix=${D}/usr sysconfdir=${D}/etc install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
