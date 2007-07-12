# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-sdl/emul-linux-x86-sdl-10.1.ebuild,v 1.3 2007/07/12 06:39:56 mr_bones_ Exp $

inherit emul-libs

SRC_URI="mirror://gentoo/libsdl-1.2.11-emul2.tbz2
	mirror://gentoo/openal-0.0.8-r1.tbz2
	mirror://gentoo/sdl-image-1.2.5-r1.tbz2
	mirror://gentoo/sdl-mixer-1.2.7.tbz2
	mirror://gentoo/sdl-net-1.2.5.tbz2
	mirror://gentoo/sdl-sound-1.0.1-r1.tbz2
	mirror://gentoo/sdl-ttf-2.0.8.tbz2
	mirror://gentoo/smpeg-0.4.4-r8.tbz2"

LICENSE="LGPL-2 LGPL-2.1"
KEYWORDS="-* amd64"

DEPEND=""
RDEPEND=">=app-emulation/emul-linux-x86-xlibs-10.0
	>=app-emulation/emul-linux-x86-soundlibs-10.0"
