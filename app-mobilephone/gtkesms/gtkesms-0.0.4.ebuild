# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/gtkesms/gtkesms-0.0.4.ebuild,v 1.2 2005/06/05 12:01:43 mrness Exp $

DESCRIPTION="GTK GUI for esms"
SRC_URI="mirror://sourceforge/esms/${P}.tar.gz"
HOMEPAGE="http://esms.sourceforge.net"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"
IUSE=""
DEPEND="=x11-libs/gtk+-1.2*
		dev-perl/gtk-perl
		app-mobilephone/esms"
SLOT="0"
src_unpack() {
	unpack gtkesms-0.0.4.tar.gz
	cd ${WORKDIR}/gtkesms-0.0.4
	patch configure < ${FILESDIR}/gtkesms.patch || die "gtk patch failed"
}

src_compile() {
	econf || die "econf failed"
	make || die "make failed"
}

src_install () {
	make DESTDIR=${D} install || die "install failed"
}
