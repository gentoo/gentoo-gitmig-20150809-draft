# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author: José Alberto Suárez López <bass@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/gtkesms/gtkesms-0.0.4.ebuild,v 1.1 2002/05/26 00:54:35 bass Exp $ 

S=${WORKDIR}/${P}
DESCRIPTION="gtk gui for esms."
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/esms/gtkesms-0.0.4.tar.gz"
HOMEPAGE="http://esms.sourceforge.net"
LICENSE="GPL"
DEPEND="x11-libs/gtk+
		dev-perl/gtk-perl
		net-misc/esms"

src_unpack() {
	unpack gtkesms-0.0.4.tar.gz
	cd ${WORKDIR}/gtkesms-0.0.4
	patch configure < ${FILESDIR}/gtkesms.patch || die "gtk patch failed"
}

src_compile() {
    econf
    make || die "make failed"
}

src_install () {
    make DESTDIR=${D} install || die "install failed"
}
	
