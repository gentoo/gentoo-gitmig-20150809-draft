# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-xlibs/emul-linux-x86-xlibs-20100409-r1.ebuild,v 1.2 2010/06/02 13:44:25 pacho Exp $

inherit emul-linux-x86

SRC_URI="mirror://gentoo/${PN}-${PV}.tar.bz2
	http://dev.gentoo.org/~pacho/emul-linux-x86-${PV}/libXScrnSaver-1.2.0.tbz2"

LICENSE="BSD FTL GPL-2 MIT MOTIF"

KEYWORDS="-* amd64 ~amd64-linux"
IUSE="opengl"

DEPEND=""
RDEPEND="~app-emulation/emul-linux-x86-baselibs-${PV}
	x11-libs/libX11
	opengl? ( app-emulation/emul-linux-x86-opengl )"
