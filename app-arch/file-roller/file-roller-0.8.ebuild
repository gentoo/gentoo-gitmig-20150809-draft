# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer:  Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-arch/file-roller/file-roller-0.8.ebuild,v 1.2 2002/05/23 06:50:08 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="File Roller is an archive manager for the GNOME environment."
SRC_URI="http://prdownloads.sourceforge.net/${PN/-/}/${P}.tar.gz"
HOMEPAGE="http://fileroller.sourceforge.net/"

DEPEND="virtual/glibc
	=x11-libs/gtk+-1.2*
	>=gnome-base/gnome-libs-1.4.1.4
	>=gnome-base/gnome-vfs-1.0.5
	>=gnome-base/libglade-0.17
	>=gnome-base/oaf-0.6.8
	>=gnome-base/bonobo-1.0.19
	>=media-libs/gdk-pixbuf-0.16.0
	nls? ( dev-util/intltool )"
	

src_compile() {
        
	local myconf
	use nls || myconf="--disable-nls"

	./configure --host=${CHOST}				\
		--prefix=/usr			  		\
		--mandir=/usr/share/man 			\
		--infodir=/usr/share/info			\
		--localstatedir=/var/lib 			\
		--sysconfdir=/etc				\
		$myconf || die
			
	emake || die
}

src_install() {
	
	make prefix=${D}/usr					\
		mandir=${D}/usr/share/man			\
		infodir=${D}/usr/share/info			\
		localstatedir=${D}/var/lib 			\
		sysconfdir=${D}/etc				\
		install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}

