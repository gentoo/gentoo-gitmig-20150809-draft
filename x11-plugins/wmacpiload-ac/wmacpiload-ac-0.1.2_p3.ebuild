# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmacpiload-ac/wmacpiload-ac-0.1.2_p3.ebuild,v 1.1 2004/07/30 01:04:40 s4t4n Exp $

MY_P="wmacpiload-0.1.2-ac3"

IUSE=""
DESCRIPTION="Hacked version of WMACPILoad, a dockapp to monitor CPU temp and battery time on ACPI kernels."
HOMEPAGE="http://perso.wanadoo.fr/acarriou/wmacpiload/index.html"
SRC_URI="http://perso.wanadoo.fr/acarriou/wmacpiload/${MY_P}.tar.bz2"

DEPEND="virtual/x11"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

S=${WORKDIR}/${MY_P}

src_install ()
{
	einstall || die "make install failed"

	mv ${D}/usr/bin/{wmacpiload,wmacpiload-ac}
	mv ${D}/usr/share/man/man1/{wmacpiload,wmacpiload-ac}.1

	dodoc NEWS TODO README THANKS AUTHORS
}
