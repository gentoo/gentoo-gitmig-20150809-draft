# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-medialibs/emul-linux-x86-medialibs-20091226.ebuild,v 1.2 2009/12/30 19:50:07 pacho Exp $

inherit emul-linux-x86

LICENSE="GPL-2 LGPL-2.1 BSD"
KEYWORDS="-* ~amd64"

IUSE=""

DEPEND=""
RDEPEND="=app-emulation/emul-linux-x86-baselibs-${PV}
		=app-emulation/emul-linux-x86-soundlibs-${PV}
		=app-emulation/emul-linux-x86-xlibs-${PV}
		=app-emulation/emul-linux-x86-sdl-${PV}
		!<media-video/mplayer-bin-1.0_rc1-r2"
