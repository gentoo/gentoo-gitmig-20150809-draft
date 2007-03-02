# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-medialibs/emul-linux-x86-medialibs-10.2.ebuild,v 1.2 2007/03/02 15:04:15 blubb Exp $

inherit emul-libs

SRC_URI="mirror://gentoo/fribidi-0.10.7.tbz2
		mirror://gentoo/lame-3.96.1.tbz2
		mirror://gentoo/libdv-1.0.0-r1.tbz2
		mirror://gentoo/libmad-0.15.1b-r2.tbz2
		mirror://gentoo/libtheora-1.0_alpha6-r1.tbz2
		mirror://gentoo/xvid-1.1.0-r3.tbz2"

LICENSE="GPL-2 LGPL-2.1 as-is xiph"
KEYWORDS="-* amd64"

DEPEND=""
RDEPEND=">=app-emulation/emul-linux-x86-baselibs-10.2
		>=app-emulation/emul-linux-x86-soundlibs-2.5-r2
		>=app-emulation/emul-linux-x86-xlibs-10.0
		!<media-video/mplayer-bin-1.0_rc1-r2"
