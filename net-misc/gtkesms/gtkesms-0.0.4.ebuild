# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gtkesms/gtkesms-0.0.4.ebuild,v 1.2 2002/05/31 21:00:54 bass Exp $ 

S=${WORKDIR}/${P}
DESCRIPTION="gtk gui for esms."
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/esms/gtkesms-0.0.4.tar.gz"
HOMEPAGE="http://esms.sourceforge.net"
LICENSE="GPL"
DEPEND="=x11-libs/gtk+-1.2.10-r8
		dev-perl/gtk-perl
		net-misc/esms"
RDEPEND="${DEPEND}"
SLOT="0"
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
	
