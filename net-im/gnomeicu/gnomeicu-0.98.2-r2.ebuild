# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gnomeicu/gnomeicu-0.98.2-r2.ebuild,v 1.3 2002/07/16 04:54:32 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Gnome ICQ Client"
SRC_URI="http://download.sourceforge.net/gnomeicu/${P}.tar.gz"
HOMEPAGE="http://gnomeicu.sourceforge.net/"
RDEPEND=">=gnome-base/gnome-libs-1.4.1.2-r2
	 >=sys-libs/gdbm-1.8.0
	 (	>=gnome-base/libglade-0.16
	 	<gnome-base/libglade-1.99.0 )
	 >=media-libs/gdk-pixbuf-0.9.0	
	 >=net-libs/gnet-1.1.0
	 gnome? ( gnome-base/gnome-core )
	 esd? ( >=media-sound/esound-0.2.23 )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext ) "

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

src_compile() {                           
	local myconf

	use esd || myconf="--disable-esd-test"

	use socks5 && myconf="${myconf} --enable-socks5"
	
	use nls || ( \
		myconf="${myconf} --disable-nls"
		mkdir ./intl
		touch ./intl/libgettext.h
	)
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
