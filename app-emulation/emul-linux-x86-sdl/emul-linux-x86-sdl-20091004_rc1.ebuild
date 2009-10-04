# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-sdl/emul-linux-x86-sdl-20091004_rc1.ebuild,v 1.1 2009/10/04 17:53:33 kingtaco Exp $

inherit emul-linux-x86

LICENSE="LGPL-2 LGPL-2.1"
KEYWORDS="-* ~amd64"

DEPEND=""
RDEPEND=">=app-emulation/emul-linux-x86-xlibs-20091004_rc1
	>=app-emulation/emul-linux-x86-baselibs-20091004_rc1
	>=app-emulation/emul-linux-x86-soundlibs-20091004_rc1
	>=app-emulation/emul-linux-x86-medialibs-20091004_rc1"
