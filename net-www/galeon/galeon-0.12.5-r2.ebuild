# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/galeon/galeon-0.12.5-r2.ebuild,v 1.1 2001/10/25 04:33:43 azarah Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A small webbrowser for gnome that uses mozillas render engine"
SRC_URI="http://prdownloads.sourceforge.net/${PN}/${P}.tar.gz"
HOMEPAGE="http://galeon.sourceforge.net"

DEPEND=">=net-www/mozilla-0.9.5-r1
	>=gnome-base/libglade-0.17-r1
	>=gnome-base/gnome-core-1.4.0.4-r1
	>=gnome-base/gnome-vfs-1.0.2-r1
	>=gnome-base/gconf-1.0.4-r2
	>=gnome-base/oaf-0.6.6-r1
	>=dev-libs/libxml-1.8.15
        >=dev-util/intltool-0.11
	>=media-libs/gdk-pixbuf-0.11.0
	gnome? ( >=gnome-base/bonobo-1.0.9
		 >=gnome-extra/bonobo-conf-0.12 )
	nls?   ( sys-devel/gettext )"

src_compile() {

	local myconf

	if [ -z "`use nls`" ] ; then
		myconf="${myconf} --disable-nls"
	fi

	if [ -n "`use gnome`" ] ; then
		myconf="${myconf} --with-gnome --enable-gnome-file-selector"
	fi

	./configure --host=${CHOST}					 \
		    --prefix=/usr					 \
		    --sysconfdir=/etc					 \
		    --localstatedir=/var/lib				 \
		    --with-mozilla-libs=${MOZILLA_FIVE_HOME}		 \
	            --with-mozilla-includes=${MOZILLA_FIVE_HOME}/include \
		    --without-debug					 \
		    --disable-applet					 \
		    $myconf || die

	emake || die
}

src_install () {

	gconftool --shutdown

	make prefix=${D}/usr						 \
	     sysconfdir=${D}/etc					 \
	     localstatedir=${D}/var/lib					 \
	     install || die

	dodoc AUTHORS ChangeLog COPYING* FAQ NEWS README TODO THANKS
}

pkg_postinst() {

	galeon-config-tool --fix-gconf-permissions
	scrollkeeper-update
}
