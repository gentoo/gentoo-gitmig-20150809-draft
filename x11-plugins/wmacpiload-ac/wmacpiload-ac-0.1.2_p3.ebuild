# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmacpiload-ac/wmacpiload-ac-0.1.2_p3.ebuild,v 1.3 2005/07/25 19:07:09 smithj Exp $

MY_P="wmacpiload-0.1.2-ac3"

IUSE=""
DESCRIPTION="Hacked version of WMACPILoad, a dockapp to monitor CPU temp and battery time on ACPI kernels."
HOMEPAGE="http://wmacpiload.tuxfamily.org/"
SRC_URI="http://perso.wanadoo.fr/acarriou/wmacpiload/${MY_P}.tar.bz2"

# it has a new homepage, but the src_uri is still from the old one. change this
# at the next version bump

DEPEND="virtual/x11"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

S=${WORKDIR}/${MY_P}

src_install ()
{
	einstall || die "make install failed"

	mv ${D}/usr/bin/{wmacpiload,wmacpiload-ac}
	mv ${D}/usr/share/man/man1/{wmacpiload,wmacpiload-ac}.1

	dodoc NEWS TODO README THANKS AUTHORS
}
