# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Holger Brueckner <darks@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/uml/uml-1.0.1.ebuild,v 1.1 2001/09/14 13:47:22 darks Exp $
 
 A=${P}.tar.gz
 S=${WORKDIR}/${P}
 DESCRIPTION="KDE 2.2 UML Drawing Utility"
 SRC_URI="http://prdownloads.sourceforge.net/uml/${A}"
 HOMEPAGE="http://uml.sourceforge.net"

 DEPEND="virtual/glibc
         >=kde-base/kdebase-2.2"
	
 RDEPEND=">=kde-base/kdebase-2.2"

 src_compile() {
     ./configure --disable-debug --mandir=${D}/usr/share/man || die
     emake || die
 }

 src_install() {
     make DESTDIR=${D} install
 }
