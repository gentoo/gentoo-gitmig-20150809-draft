# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer:  Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-arch/file-roller/file-roller-0.7.ebuild,v 1.2 2002/05/27 17:27:34 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="File Roller is an archive manager for the GNOME environment."
SRC_URI="mirror://sourceforge/${PN/-/}/${P}.tar.gz"
HOMEPAGE="http://fileroller.sourceforge.net/"

DEPEND="virtual/glibc
	virtual/x11
	x11-libs/gtk+
	>=gnome-base/gnome-libs-1.2.0
	>=gnome-base/gnome-vfs-1.0.0
	>=gnome-base/libglade-0.14
	>=gnome-base/oaf-0.6.5
	>=gnome-base/bonobo-1.0.0
	>=media-libs/gdk-pixbuf-0.9.0
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

