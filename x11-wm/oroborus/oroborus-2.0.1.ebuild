# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <lamer@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-wm/oroborus/oroborus-2.0.1.ebuild,v 1.1 2001/08/02 04:35:59 lamer Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Yet another window manager"
SRC_URI="http://www.kensden.pwp.blueyonder.co.uk/Oroborus/files/${P}.tar.gz"
HOMEPAGE="http://www.kensden.pwp.blueyonder.co.uk/Oroborus"
DEPEND=""

#RDEPEND=""

src_compile() {
	try ./configure --infodir=/usr/share/info --mandir=/usr/share/man --prefix=/usr --host=${CHOST}
	
	try make
}

src_install () {
	
	# try make prefix=${D}/usr install

    try make DESTDIR=${D} install
	 dodoc README INSTALL ChangeLog TODO NEWS AUTHORS example.oroborusrc
}

