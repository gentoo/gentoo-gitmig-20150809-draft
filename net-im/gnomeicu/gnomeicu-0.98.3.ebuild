# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gnomeicu/gnomeicu-0.98.3.ebuild,v 1.8 2003/05/09 22:52:29 liquidx Exp $

IUSE="nls esd gnome"

inherit debug 

S=${WORKDIR}/${P}
DESCRIPTION="Gnome ICQ Client"
SRC_URI="mirror://sourceforge/gnomeicu/${P}.tar.bz2"
HOMEPAGE="http://gnomeicu.sourceforge.net/"

DEPEND=">=gnome-base/gnome-libs-1.4.1.2-r2
	>=sys-libs/gdbm-1.8.0
	=gnome-base/libglade-0.17*
	>=media-libs/gdk-pixbuf-0.9.0	
	>=net-libs/gnet-1.1.0
	gnome? ( =gnome-base/gnome-panel-1.4* )
	esd? ( >=media-sound/esound-0.2.23 )"

	# socks5? ( something to support socks5 in portage is needed )

RDEPEND="nls? ( sys-devel/gettext )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

src_compile() {                           
	local myconf

	myconf="--prefix=/usr"

	use esd || myconf="${myconf} --disable-esd-test"
	
	# Disabling socks5 support. if socks5 is present
	# in USE, gnomeicu buid will fail. Check ChangeLog
	# for more info about this issue. stroke@gentoo.org 
	# use socks5 && myconf="${myconf} --enable-socks5"
	
	use nls || ( \
		myconf="${myconf} --disable-nls"
		mkdir ./intl
		touch ./intl/libgettext.h
	)

	# remove the panel applet if you dont use gnome,
	# nice hack for gnome2 compability

	use gnome || myconf="${myconf} --disable-applet" 	

	econf \
		${myconf} --enable-debug || die

	emake || die
}

src_install() {
	make DESTDIR=${D} \
	     sysconfdir=${D}/etc \
	     localstatedir=${D}/var/log	\
	     install || die

	dodoc AUTHORS COPYING CREDITS ChangeLog NEWS README TODO ABOUT-NLS
}
