# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/ion-dock/ion-dock-20030327.ebuild,v 1.1 2003/04/06 20:51:25 mholzer Exp $

ION_VERSION=20030327
inherit ion

DESCRIPTION="A dock module for the window manager Ion"
HOMEPAGE="http://kanin.dsv.su.se/ion/dock/"
SRC_URI="${SRC_URI} http://kanin.dsv.su.se/ion/dock/${P}.tar.gz"
LICENSE="Clarified-Artistic"
SLOT="0"
KEYWORDS="~x86"
IUSE="truetype"
DEPEND="${DEPEND} =x11-wm/ion-devel-${ION_VERSION}*"

src_compile() {

	ion_src_configure ${WORKDIR}/ion-devel-${ION_VERSION}

	cp Makefile Makefile.orig
	sed -e "s:^ION_DIR = /usr/include/ion-devel:ION_DIR=${WORKDIR}/ion-devel-${ION_VERSION}:" \
		-e "s/^CFLAGS := -g -O2 -fPIC \$(WARN) \$(DEFINES) \$(INCLUDES) \$(X11_INCLUDES) \\\\/CFLAGS := ${CFLAGS} -fPIC \$(WARN) \$(DEFINES) \$(INCLUDES) \$(X11_INCLUDES) \\\\/" \
		Makefile.orig > Makefile

	emake || die

}

src_install() {
	dodir /etc/X11/ion-devel
	dodir /usr/lib/ion-devel
	make PREFIX=${D}/usr ETCDIR=${D}/etc/X11 LIBDIR=${D}/usr/lib install || die
	dodoc README ChangeLog
}

pkg_postinst() {
	einfo "To enable ion-dock add \"module \"dock\"\" to ~/.ion-devel/ioncore.conf"
}
