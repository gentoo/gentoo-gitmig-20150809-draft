# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/astrolog-ephemeris/astrolog-ephemeris-5.40.ebuild,v 1.2 2004/03/03 13:07:42 phosphan Exp $

DESCRIPTION="ephemeris files for optional extended accuracy of astrolog's calculations"
HOMEPAGE="http://www.astrolog.org/astrolog.htm"
SRC_URI="http://www.astrolog.org/ftp/ephem/ephemall.zip"
LICENSE="astrolog"
SLOT="0"

# works fine on x86 - runs probably on other architectures, too
KEYWORDS="x86"

S="${WORKDIR}"

DEPEND="app-misc/astrolog"

src_install() {
	dodir /usr/share/astrolog
	cp * ${D}/usr/share/astrolog
}
