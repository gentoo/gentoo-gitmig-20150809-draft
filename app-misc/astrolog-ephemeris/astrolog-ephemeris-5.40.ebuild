# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/astrolog-ephemeris/astrolog-ephemeris-5.40.ebuild,v 1.11 2005/09/16 03:08:06 mr_bones_ Exp $

DESCRIPTION="ephemeris files for optional extended accuracy of astrolog's calculations"
HOMEPAGE="http://www.astrolog.org/astrolog.htm"
SRC_URI="http://www.astrolog.org/ftp/ephem/ephemall.zip"

LICENSE="astrolog"
SLOT="0"
# works fine on x86 - runs probably on other architectures, too
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

DEPEND="app-arch/unzip"

S=${WORKDIR}

DEPEND="app-misc/astrolog"

src_install() {
	dodir /usr/share/astrolog
	cp * "${D}"/usr/share/astrolog || die "cp failed"
}
