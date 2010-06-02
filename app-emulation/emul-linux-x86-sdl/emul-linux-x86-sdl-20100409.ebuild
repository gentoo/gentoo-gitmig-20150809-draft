# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-sdl/emul-linux-x86-sdl-20100409.ebuild,v 1.2 2010/06/02 13:43:10 pacho Exp $

inherit emul-linux-x86

LICENSE="LGPL-2 LGPL-2.1"
KEYWORDS="-* amd64"
IUSE=""

DEPEND=""
RDEPEND="~app-emulation/emul-linux-x86-xlibs-${PV}
	~app-emulation/emul-linux-x86-baselibs-${PV}
	~app-emulation/emul-linux-x86-soundlibs-${PV}
	~app-emulation/emul-linux-x86-medialibs-${PV}"
