# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mikael Hallendal <micke@hallendal.net>
# $Header: /var/cvsroot/gentoo-x86/app-office/mrproject/mrproject-0.4.1.ebuild,v 1.1 2001/10/11 19:42:51 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Project management application for GNOME"
SRC_URI="ftp://ftp.codefactory.se/pub/software/mrproject/source/${P}.tar.gz"
HOMEPAGE="http://mrproject.codefactory.se/"

RDEPEND=">=media-libs/gdk-pixbuf-0.11.0-r1
	 >=gnome-base/ORBit-0.5.10-r1
         >=gnome-extra/gal-0.13-r1
	 >=gnome-base/bonobo-1.0.9-r1
	 >=gnome-base/libglade-0.17-r1
	 >=dev-libs/libxml-1.8.15
	 >=gnome-base/gconf-1.0.4-r2
	 >=gnome-base/gnome-vfs-1.0.2-r1
	 >=gnome-base/oaf-0.6.6-r1
	 >=gnome-base/gnome-print-0.30"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	>=dev-util/xml-i18n-tools-0.8.4"

src_compile() {
	local myconf

	if [ -z "`use nls`" ] ; then
		myconf="--disable-nls"
	fi

	./configure --host=${CHOST} 					\
		    --prefix=/usr 					\
		    --sysconfdir=/etc					\
		    --localstatedir=/var/lib				\
		    --disable-more-warnings 				\
		    --without-python $myconf || die

	emake || die
}

src_install () {
	make prefix=${D}/usr						\
	     sysconfdir=${D}/etc					\
	     localstatedir=${D}/var/lib					\
	     install || die

	dodoc AUTHORS COPYING ChangeLog README NEWS TODO
}



