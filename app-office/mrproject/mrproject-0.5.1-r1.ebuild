# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/mrproject/mrproject-0.5.1-r1.ebuild,v 1.5 2003/06/10 13:33:10 liquidx Exp $

IUSE="nls"

S=${WORKDIR}/${P}
DESCRIPTION="Project management application for GNOME"
SRC_URI="ftp://ftp.codefactory.se/pub/software/mrproject/source/${P}.tar.gz"
HOMEPAGE="http://mrproject.codefactory.se/"
SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86"

RDEPEND=">=media-libs/gdk-pixbuf-0.18
	>=gnome-base/ORBit-0.5.16
	<gnome-extra/gal-1.99
	>=gnome-base/bonobo-1.0.19
	( >=gnome-base/libglade-0.17-r1
	 <gnome-base/libglade-2.0.0 )
	>=dev-libs/libxml-1.8.15
	=gnome-base/gconf-1.0*
	=gnome-base/gnome-vfs-1.0*
	>=gnome-base/oaf-0.6.8
	>=gnome-base/gnome-print-0.34"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	>=dev-util/intltool-0.11"

src_compile() {
	local myconf

	if [ -z "`use nls`" ] ; then
		myconf="--disable-nls"
	fi

	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var/lib \
		--disable-more-warnings \
		--without-python $myconf || die

	emake || die
}

src_install () {
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		localstatedir=${D}/var/lib \
		install || die

	dodoc AUTHORS COPYING ChangeLog README NEWS TODO
}
