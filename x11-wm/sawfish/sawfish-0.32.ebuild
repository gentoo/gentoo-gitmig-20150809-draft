# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-wm/sawfish/sawfish-0.32.ebuild,v 1.2 2000/10/28 04:17:42 drobbins Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Extensible window manager using a Lisp-based scripting language"
SRC_URI="ftp://sawmill.sourceforge.net/pub/sawmill/"${A}
HOMEPAGE="http://sawmill.sourceforge.net/"
DEPEND="dev-libs/gmp dev-libs/librep dev-libs/rep-gtk x11-libs/gtk+ media-libs/audiofile media-sound/esound media-libs/imlib gnome? ( gnome-base/gnome-core )"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  	cd ${S}
 	if [ -n "`use gnome`" ]
	then
  		try ./configure --host=${CHOST} --prefix=/usr/X11R6 --infodir=/usr/info --with-audiofile --with-esd --with-gnome-prefix=/opt/gnome
	else
		try ./configure --host=${CHOST} --prefix=/usr/X11R6 --infodir=/usr/info --with-audiofile --with-esd 
	fi	
	#pmake doesn't work, stick with make
	try make
}

src_install() {                               
  cd ${S}
  try make DESTDIR=${D} install
  prepinfo /usr/X11R6
  dodoc AUTHORS BUGS COPYING ChangeLog DOC FAQ NEWS README THANKS TODO
}



