# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/splash-themes-livecd/splash-themes-livecd-2004.3.ebuild,v 1.1 2004/10/12 22:44:31 wolf31o2 Exp $

IUSE="livecd bootsplash"
S=${WORKDIR}/livecd-${PV}
DESCRIPTION="Gentoo ${PV} theme for bootsplash consoles"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="http://dev.gentoo.org/~wolf31o2/sources/${PN}/${PF}.tar.bz2"

SLOT=${PV}
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

DEPEND="bootsplash? ( >=media-gfx/bootsplash-0.6-r16 )
	!bootsplash? ( media-gfx/splashutils )"

src_install() {
	if use bootsplash; then
		dodir /etc/bootsplash/livecd-${PV}
		cp -r ${S}/* ${D}/etc/bootsplash/livecd-${PV}
	else
		dodir /etc/splash/livecd-${PV}
		cp -r ${S}/* ${D}/etc/splash/livecd-${PV}
	fi
}
