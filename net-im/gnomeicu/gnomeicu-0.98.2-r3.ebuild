# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Joshua Pierre <joshua@swool.com>, Maintainer Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-im/gnomeicu/gnomeicu-0.98.2-r3.ebuild,v 1.1 2002/06/28 01:51:40 spider Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Gnome ICQ Client"
SRC_URI="http://download.sourceforge.net/gnomeicu/${P}.tar.gz"
HOMEPAGE="http://gnomeicu.sourceforge.net/"
SLOT="0"
RDEPEND=">=gnome-base/gnome-libs-1.4.1.2-r2
	 >=sys-libs/gdbm-1.8.0
	 (	>=gnome-base/libglade-0.16
	 	<gnome-base/libglade-1.99.0 )
	 >=media-libs/gdk-pixbuf-0.9.0	
	 >=net-libs/gnet-1.1.0
	 gnome? ( >=gnome-base/gnome-panel-1.4.1 
	 		<gnome-base/gnome-panel-1.5.0 )
	 esd? ( >=media-sound/esound-0.2.23 )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext ) "

src_compile() {                           
	local myconf

	if [ -z "`use esd`" ]
	then
		myconf="--disable-esd-test"
	fi
	if [ "`use socks5`" ];
	then
		myconf="${myconf} --enable-socks5"
	fi
	
	if [ -z "`use nls`" ]
	then
		myconf="${myconf} --disable-nls"
		mkdir ./intl
		touch ./intl/libgettext.h
	fi
	# remove the panel applet if you dont use gnome, nice hack for gnome2 compability
	use gnome || myconf="${myconf} --disable-applet" 	
	./configure --host=${CHOST} \
		    --prefix=/usr \
		    --sysconfdir=/etc \
		    --localstatedir=/var/lib \
		    ${myconf} || die

	emake || die
}

src_install() {
	make prefix=${D}/usr \
	     sysconfdir=${D}/etc \
	     localstatedir=${D}/var/log	\
	     install || die

	dodoc AUTHORS COPYING CREDITS ChangeLog NEWS README TODO ABOUT-NLS
}
