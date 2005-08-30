# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mplayer-bin/mplayer-bin-1.0_pre7.ebuild,v 1.3 2005/08/30 21:59:11 dang Exp $

DESCRIPTION="Pre-build mplayer binary for amd64 systems"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE=""

RDEPEND=">=app-emulation/emul-linux-x86-baselibs-2.0
	>=app-emulation/emul-linux-x86-soundlibs-2.1
	>=app-emulation/emul-linux-x86-gtklibs-2.1
	>=app-emulation/emul-linux-x86-sdl-2.1
	>=app-emulation/emul-linux-x86-medialibs-1.0
	>=media-libs/win32codecs-20050412"

S=${WORKDIR}

src_install() {
	cp -RPvf ${WORKDIR}/* ${D}/
}
