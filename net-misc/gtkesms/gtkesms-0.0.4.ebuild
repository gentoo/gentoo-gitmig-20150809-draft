# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gtkesms/gtkesms-0.0.4.ebuild,v 1.6 2002/08/14 12:08:07 murphy Exp $ 

S=${WORKDIR}/${P}
DESCRIPTION="gtk gui for esms."
SRC_URI="mirror://sourceforge/esms/${P}.tar.gz"
HOMEPAGE="http://esms.sourceforge.net"
LICENSE="GPL"
KEYWORDS="x86 sparc sparc64"
DEPEND="=x11-libs/gtk+-1.2*
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
	
