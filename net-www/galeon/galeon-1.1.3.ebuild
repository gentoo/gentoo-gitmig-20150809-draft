# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/galeon/galeon-1.1.3.ebuild,v 1.2 2002/03/13 04:28:58 blocke Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A small webbrowser for gnome that uses mozillas render engine"
SRC_URI="http://download.sourceforge.net/${PN}/${P}.tar.gz
	 http://prdownloads.sourceforge.net/${PN}/${P}.tar.gz"
HOMEPAGE="http://galeon.sourceforge.net"

DEPEND=">=dev-libs/libxml-1.8.16
        >=dev-util/intltool-0.11
	=net-www/mozilla-0.9.8
	>=gnome-base/libglade-0.17-r1
	>=gnome-base/gnome-core-1.4.0.4-r1
	>=gnome-base/gnome-vfs-1.0.2-r1
	>=gnome-base/gconf-1.0.7-r2
	>=gnome-base/oaf-0.6.7
	>=media-libs/gdk-pixbuf-0.16.0-r1
	nls? ( sys-devel/gettext )"


src_compile() {

	local myconf

	if [ -z "`use nls`" ] ; then
		myconf="--disable-nls"
	fi

	./configure --host=${CHOST}					 \
		    --prefix=/usr					 \
		    --sysconfdir=/etc					 \
		    --localstatedir=/var/lib				 \
		    --with-mozilla-libs=${MOZILLA_FIVE_HOME}		 \
	            --with-mozilla-includes=${MOZILLA_FIVE_HOME}/include \
		    --without-debug					 \
		    --disable-applet					 \
		    --disable-install-schemas				 \
		    $myconf || die

	emake || die
}

src_install() {

	gconftool --shutdown

	make prefix=${D}/usr						 \
	     sysconfdir=${D}/etc					 \
	     localstatedir=${D}/var/lib					 \
	     install || die

	dodoc AUTHORS ChangeLog COPYING* FAQ NEWS README TODO THANKS
}

pkg_postinst() {

	galeon-config-tool --fix-gconf-permissions
	galeon-config-tool --pkg-install-schemas
	scrollkeeper-update
}
