# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-sdl/emul-linux-x86-sdl-20120127.ebuild,v 1.1 2012/01/27 18:12:56 pacho Exp $

EAPI="4"

inherit emul-linux-x86

LICENSE="LGPL-2 LGPL-2.1"
KEYWORDS="-* ~amd64"
IUSE="pulseaudio"

SRC_URI="${SRC_URI}
	!pulseaudio? ( http://dev.gentoo.org/~pacho/emul-linux-x86-${PV}/libsdl-1.2.14-r6_${PV}.tbz2 )"

DEPEND=""
RDEPEND="~app-emulation/emul-linux-x86-xlibs-${PV}
	~app-emulation/emul-linux-x86-baselibs-${PV}
	~app-emulation/emul-linux-x86-soundlibs-${PV}[pulseaudio?]
	~app-emulation/emul-linux-x86-medialibs-${PV}"
