# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/galeon/galeon-0.12.4-r1.ebuild,v 1.2 2001/10/22 10:11:32 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A small webbrowser for gnome that uses mozillas render engine"
SRC_URI="http://prdownloads.sourceforge.net/${PN}/${P}.tar.gz"
HOMEPAGE="http://galeon.sourceforge.net"

DEPEND=">=net-www/mozilla-0.9.5
	>=gnome-base/libglade-0.17-r1
	>=gnome-base/gnome-core-1.4.0.4-r1
	>=dev-libs/libxml-1.8.15
	>=gnome-base/gnome-vfs-1.0.2-r1
	>=gnome-base/gconf-1.0.4-r2
        >=dev-util/intltool-0.11
	>=gnome-base/oaf-0.6.6-r1
	nls? ( sys-devel/gettext )"


src_unpack() {

	unpack ${A}
		
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}-gentoo.patch
}

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
		    --with-gnome					 \
		    --without-debug					 \
		    --enable-applet					 \
		    --enable-gnome-file-selector			 \
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
