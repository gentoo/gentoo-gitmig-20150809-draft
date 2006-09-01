# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/splash-themes-livecd/splash-themes-livecd-2006.1.ebuild,v 1.1 2006/09/01 23:17:35 wolf31o2 Exp $

MY_P="gentoo-livecd-${PV}"
MY_REV="0.9.4"
DESCRIPTION="Gentoo theme for gensplash consoles"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="http://dev.gentoo.org/~wolf31o2/sources/${PN}/${MY_P}-${MY_REV}.tar.bz2"

SLOT=${PV}
LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=">=media-gfx/splashutils-1.1.9.10-r1"

S=${WORKDIR}/${MY_P}

src_install() {
	dodir /etc/splash/livecd-${PV}
	cp -r ${S}/* ${D}/etc/splash/livecd-${PV}
}
