# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/splash-themes-livecd/splash-themes-livecd-2005.0.ebuild,v 1.4 2007/02/15 15:23:20 wolf31o2 Exp $

MY_P="gentoo-livecd-${PV}"
MY_REV="0.9.1"
DESCRIPTION="Gentoo theme for gensplash consoles"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="http://dev.gentoo.org/~wolf31o2/sources/${PN}/${MY_P}-${MY_REV}.tar.bz2"

SLOT=${PV}
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ~ppc"
IUSE=""
RESTRICT="binchecks strip"

DEPEND=">=media-gfx/splashutils-0.9.1"

S=${WORKDIR}/${MY_P}

src_install() {
	dodir /etc/splash/livecd-${PV}
	cp -r ${S}/* ${D}/etc/splash/livecd-${PV}
}
