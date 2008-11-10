# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-sdl/emul-linux-x86-sdl-20081109.ebuild,v 1.1 2008/11/10 03:30:49 kingtaco Exp $

inherit emul-linux-x86

LICENSE="LGPL-2 LGPL-2.1"
KEYWORDS="-* ~amd64"

DEPEND=""
RDEPEND=">=app-emulation/emul-linux-x86-xlibs-20081109
	>=app-emulation/emul-linux-x86-baselibs-20081109
	>=app-emulation/emul-linux-x86-soundlibs-20081109"
