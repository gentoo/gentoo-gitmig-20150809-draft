# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmacpiload-ac/wmacpiload-ac-0.1.2_p3.ebuild,v 1.5 2006/01/22 12:14:11 nelchael Exp $

MY_P="wmacpiload-0.1.2-ac3"

IUSE=""
DESCRIPTION="Hacked version of WMACPILoad, a dockapp to monitor CPU temp and battery time on ACPI kernels."
HOMEPAGE="http://wmacpiload.tuxfamily.org/"
SRC_URI="http://perso.wanadoo.fr/acarriou/wmacpiload/${MY_P}.tar.bz2"

# it has a new homepage, but the src_uri is still from the old one. change this
# at the next version bump

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXt
		x11-libs/libXext
		x11-libs/libXpm )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( x11-proto/xextproto virtual/x11 )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64"

S=${WORKDIR}/${MY_P}

src_install ()
{
	einstall || die "make install failed"

	mv ${D}/usr/bin/{wmacpiload,wmacpiload-ac}
	mv ${D}/usr/share/man/man1/{wmacpiload,wmacpiload-ac}.1

	dodoc NEWS TODO README THANKS AUTHORS
}
