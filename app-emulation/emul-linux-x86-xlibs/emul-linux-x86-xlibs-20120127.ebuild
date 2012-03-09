# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-xlibs/emul-linux-x86-xlibs-20120127.ebuild,v 1.2 2012/03/09 14:54:07 ssuominen Exp $

EAPI="4"

inherit emul-linux-x86

LICENSE="FTL GPL-2 MIT"

KEYWORDS="-* amd64"
IUSE="opengl"

DEPEND=""
RDEPEND="~app-emulation/emul-linux-x86-baselibs-${PV}
	x11-libs/libX11
	opengl? ( app-emulation/emul-linux-x86-opengl )"
