# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-wm/sawfish/sawfish-0.35.ebuild,v 1.1 2001/01/09 19:58:50 drobbins Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Extensible window manager using a Lisp-based scripting language"
SRC_URI="ftp://sawmill.sourceforge.net/pub/sawmill/"${A}
HOMEPAGE="http://sawmill.sourceforge.net/"
DEPEND=">=dev-libs/rep-gtk-0.14
	>=media-sound/esound-0.2.19 
	>=media-libs/imlib-0.9.8.1 
	gnome? ( >=gnome-base/gnome-core-1.2.2.1
		 >=gnome-base/libglade-0.14 )"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  	cd ${S}
 	if [ -n "`use gnome`" ]
	then
  		try ./configure --host=${CHOST} --prefix=/usr/X11R6 --with-audiofile --with-esd \
				--with-gnome-prefix=/opt/gnome
	else
		try ./configure --host=${CHOST} --prefix=/usr/X11R6 --with-audiofile --with-esd 
	fi	
	#pmake doesn't work, stick with make
	try make
}

src_install() {                               
  cd ${S}
  try make DESTDIR=${D} install
  dodoc AUTHORS BUGS COPYING ChangeLog DOC FAQ NEWS README THANKS TODO
}



