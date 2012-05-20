# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-xlibs/emul-linux-x86-xlibs-20120520.ebuild,v 1.1 2012/05/20 13:15:02 pacho Exp $

EAPI="4"

inherit emul-linux-x86

LICENSE="FTL GPL-2 MIT"

KEYWORDS="-* ~amd64"
IUSE="opengl"

DEPEND=""
RDEPEND="~app-emulation/emul-linux-x86-baselibs-${PV}
	x11-libs/libX11
	opengl? ( app-emulation/emul-linux-x86-opengl )"
