# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkmm/gtkmm-1.2.9.ebuild,v 1.1 2002/04/09 19:08:15 spider Exp $

S=${WORKDIR}/${P}
DESCRIPTION="C++ interface for GTK+"
SRC_URI="http://download.sourceforge.net/gtkmm/${P}.tar.gz"
#	 ftp://ftp.gnome.org/pub/GNOME/stable/sources/gtk+/${P}.tar.gz
#	 http://ftp.gnome.org/pub/GNOME/stable/sources/gtk+/${P}.tar.gz"
HOMEPAGE="http://gtkmm.sourceforge.net/"

DEPEND="virtual/glibc
	>=x11-libs/gtk+-1.2.10-r4
	>=dev-libs/libsigc++-1.0.4"


src_compile() {

	local myconf
	
	if [ "${DEBUG}" ]
	then
		myconf="--enable-debug=yes"
	else
		myconf="--enable-debug=no"
	fi
	
  	./configure --host=${CHOST}			\
		--prefix=/usr				\
		--infodir=/usr/share/info		\
		--mandir=/usr/share/man			\
		--sysconfdir=/etc/X11			\
		--with-xinput=xfree			\
		--with-x				\
		${myconf} || die
		
	make || die
}

src_install() {

	make DESTDIR=${D}				\
		install || die


	dodoc AUTHORS COPYING ChangeLog* HACKING
	dodoc NEWS* README* TODO
}




