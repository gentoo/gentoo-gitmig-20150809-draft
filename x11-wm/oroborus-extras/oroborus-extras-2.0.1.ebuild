# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <lamer@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-wm/oroborus-extras/oroborus-extras-2.0.1.ebuild,v 1.1 2001/08/02 04:35:59 lamer Exp $
A="deskmenu-1.3.0.tar.gz keylaunch-1.3.0.tar.gz desklaunch-1.1.0.tar.gz" 
A2="keylaunch-1.3.0.tar.gz"
A3="desklaunch-1.1.0.tar.gz"
S=${WORKDIR}
DESCRIPTION="Other stuff for oroborus"
SRC_URI="http://www.kensden.pwp.blueyonder.co.uk/Oroborus/files/${A}
http://www.kensden.pwp.blueyonder.co.uk/Oroborus/files/${A2}
http://www.kensden.pwp.blueyonder.co.uk/Oroborus/files/${A3}"
HOMEPAGE="http://www.kensden.pwp.blueyonder.co.uk/Oroborus/"
DEPEND=""

#RDEPEND=""

src_unpack() {
	unpack ${A}
	unpack ${A2}
	unpack ${A3}
	cd ${S}/keylaunch
	sed -e "s:\/usr\/X11:\/usr\/X11R6:" Makefile |cat > Makefile
}


src_compile() {

# Deskmenu first
	cd ${S}/deskmenu-1.3.0
	try make

# Keylaunch next
	cd ${S}/keylaunch
   try make

# desklaunch third
	cd ${S}/desklaunch
   try make
}

src_install () {
# make the dirs
	dodir /usr/X11R6/bin
# Deskmenu first
	cd ${S}/deskmenu-1.3.0
    try make PREFIX=${D}/usr/X11R6 install
	newdoc README README.deskmenu
	newdoc CHANGES CHANGES.deskmenu
	newdoc example_rc example.deskmenurc
	dodoc license

# Keylaunch next 
	cd ${S}/keylaunch
	try make PREFIX=${D}/usr/X11R6 install
	newdoc README README.keylaunch
	newdoc example_rc example_rc_keylaunch

# desklaunch third
   cd ${S}/desklaunch
	try make PREFIX=${D}/usr/X11R6 install
	newdoc README README.desklaunch
}

