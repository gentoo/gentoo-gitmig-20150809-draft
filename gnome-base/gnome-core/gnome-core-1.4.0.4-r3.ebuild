# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-core/gnome-core-1.4.0.4-r3.ebuild,v 1.1 2001/10/29 18:34:41 azarah Exp $

S=${WORKDIR}/${P}
DESCRIPTION="gnome-core"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"

RDEPEND=">=gnome-base/control-center-1.4.0.1-r1
	 >=gnome-base/libglade-0.17-r1
	 >=gnome-base/gnome-libs-1.4.1.2-r1"

DEPEND="${RDEPEND}
        nls? ( sys-devel/gettext )
        >=sys-apps/tcp-wrappers-7.6
        >=app-text/scrollkeeper-0.2
	>=dev-util/intltool-0.11"

src_compile() {
	local myconf
	local myldflags

	if [ -z "`use nls`" ]
	then
		myconf="--disable-nls"
	fi

	if [ "`use kde`" ]
	then
		myconf="${myconf} --with-kde-datadir=/usr/share"
	fi

	# Fix build agains gdk-pixbuf-0.12 and later
	CFLAGS="${CFLAGS} `gdk-pixbuf-config --cflags`"

	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --sysconfdir=/etc					\
		    --localstatedir=/var/lib				\
		    ${myconf} || die

	emake || die
}

src_install() {
	make prefix=${D}/usr						\
	     sysconfdir=${D}/etc					\
  	     localstatedir=${D}/var/lib					\
	     install || die

	dodoc AUTHORS COPYING* ChangeLog README NEWS
}
