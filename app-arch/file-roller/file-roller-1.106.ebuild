# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-arch/file-roller/file-roller-1.106.ebuild,v 1.1 2002/05/27 10:13:08 spider Exp $

S=${WORKDIR}/${P}
SLOT="0"
DESCRIPTION="File Roller is an archive manager for the GNOME environment."
SRC_URI="ftp://download.sourceforge.net/pub/sourceforge/${PN/-/}/${P}.tar.gz"
HOMEPAGE="http://fileroller.sourceforge.net/"
LICENSE="GPL-2"


RDEPEND="virtual/glibc
	=x11-libs/gtk+-2.0*
        >=gnome-base/gnome-vfs-1.9.15	
	>=gnome-base/libglade-1.99.12	
	>=gnome-base/bonobo-activation-0.9.9
	>=gnome-base/libbonobo-1.112.0
	>=gnome-base/nautilus-1.1.12"

DEPEND="${RDEPEND}
	nls? ( dev-util/intltool )"

src_compile() {
        
	local myconf
	use nls || myconf="--disable-nls"

	./configure --host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--localstatedir=/var/lib \
		--sysconfdir=/etc \
		${myconf} || die
			
	emake || die
}

src_install() {
	
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		localstatedir=${D}/var/lib \
		sysconfdir=${D}/etc \
		install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}

