# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Achim Gottinger <achim@gentoo.org>
# Maintainer:  Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkmm/gtkmm-1.2.8.ebuild,v 1.3 2002/05/23 06:50:19 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="C++ interface for GTK+"
SRC_URI="http://download.sourceforge.net/gtkmm/${P}.tar.gz"
#	 ftp://ftp.gnome.org/pub/GNOME/stable/sources/gtk+/${P}.tar.gz
#	 http://ftp.gnome.org/pub/GNOME/stable/sources/gtk+/${P}.tar.gz"
HOMEPAGE="http://gtkmm.sourceforge.net/"

DEPEND="virtual/glibc
	=x11-libs/gtk+-1.2*
	>=dev-libs/libsigc++-1.0.4"

RDEPEND=${DEPEND}
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




