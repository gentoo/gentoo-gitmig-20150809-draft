# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/ggv/ggv-1.1.91.ebuild,v 1.1 2001/11/09 02:18:31 hallski Exp $


S=${WORKDIR}/${P}
DESCRIPTION="Gnome Ghostview"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${P}.tar.gz"
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
		CFLAGS="${CFLAGS} `gnome-config --cflags bonobo bonobox`"
	else
		myconf="$myconf --without-bonobo"
	fi

	CFLAGS="$CFLAGS `gdk-pixbuf-config --cflags`"

	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --sysconfdir=/etc					\
		    --localstatedir=/var/lib				\
		    $myconf || die

	emake || die
}

src_install() {
	gconftool --shutdown

	make prefix=${D}/usr						\
	     sysconfdir=${D}/etc					\
	     localstatedir=${D}/var/lib					\
	     install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}

