# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-medialibs/emul-linux-x86-medialibs-20081109.ebuild,v 1.2 2009/11/03 21:10:27 ssuominen Exp $

inherit emul-linux-x86

LICENSE="GPL-2 LGPL-2.1 as-is BSD"
KEYWORDS="-* amd64"

DEPEND=""

RDEPEND=">=app-emulation/emul-linux-x86-baselibs-20081109
		>=app-emulation/emul-linux-x86-soundlibs-20081109
		>=app-emulation/emul-linux-x86-xlibs-20081109
		>=app-emulation/emul-linux-x86-sdl-20081109
		!<media-video/mplayer-bin-1.0_rc1-r2"
