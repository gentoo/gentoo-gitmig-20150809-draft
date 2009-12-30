# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-sdl/emul-linux-x86-sdl-20081109.ebuild,v 1.3 2009/12/30 19:52:08 pacho Exp $

inherit emul-linux-x86

LICENSE="LGPL-2 LGPL-2.1"
KEYWORDS="-* amd64"

DEPEND=""
RDEPEND="=app-emulation/emul-linux-x86-xlibs-${PV}
	=app-emulation/emul-linux-x86-baselibs-${PV}
	=app-emulation/emul-linux-x86-soundlibs-${PV}"
