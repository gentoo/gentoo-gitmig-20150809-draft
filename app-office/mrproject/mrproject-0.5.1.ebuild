# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-office/mrproject/mrproject-0.5.1.ebuild,v 1.3 2002/07/11 06:30:17 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Project management application for GNOME"
SRC_URI="ftp://ftp.codefactory.se/pub/software/mrproject/source/${P}.tar.gz"
HOMEPAGE="http://mrproject.codefactory.se/"

RDEPEND=">=media-libs/gdk-pixbuf-0.11.0-r1
	>=gnome-base/ORBit-0.5.10-r1
	>=gnome-extra/gal-0.18.1
	>=gnome-base/bonobo-1.0.17
	>=gnome-base/libglade-0.17-r1
	>=dev-libs/libxml-1.8.15
	>=gnome-base/gconf-1.0.7
	>=gnome-base/gnome-vfs-1.0.3
	>=gnome-base/oaf-0.6.6-r1
	>=gnome-base/gnome-print-0.34"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	>=dev-util/intltool-0.11"

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
