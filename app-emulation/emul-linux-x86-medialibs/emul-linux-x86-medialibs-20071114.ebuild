# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-medialibs/emul-linux-x86-medialibs-20071114.ebuild,v 1.2 2007/11/24 01:21:35 kingtaco Exp $

inherit emul-linux-x86

LICENSE="GPL-2 LGPL-2.1 as-is BSD"
KEYWORDS="-* amd64"

DEPEND=""

RDEPEND=">=app-emulation/emul-linux-x86-baselibs-20071114
		>=app-emulation/emul-linux-x86-soundlibs-20071114
		>=app-emulation/emul-linux-x86-xlibs-20071114
		>=app-emulation/emul-linux-x86-sdl-20071114
		!<media-video/mplayer-bin-1.0_rc1-r2"
