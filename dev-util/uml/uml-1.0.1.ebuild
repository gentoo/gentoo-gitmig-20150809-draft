# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Holger Brueckner <darks@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/uml/uml-1.0.1.ebuild,v 1.3 2002/05/27 17:27:38 drobbins Exp $
 
S=${WORKDIR}/${P}
DESCRIPTION="KDE 2.2 UML Drawing Utility"
SRC_URI="mirror://sourceforge/uml/${P}.tar.gz"
HOMEPAGE="http://uml.sourceforge.net"

RDEPEND=">=kde-base/kdebase-2.2"

DEPEND="${RDEPEND}
	virtual/glibc"

src_compile() {
	./configure --disable-debug --mandir=${D}/usr/share/man || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
