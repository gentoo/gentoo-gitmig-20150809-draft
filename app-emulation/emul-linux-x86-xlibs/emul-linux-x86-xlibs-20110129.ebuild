# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-xlibs/emul-linux-x86-xlibs-20110129.ebuild,v 1.2 2011/02/12 20:21:16 hwoarang Exp $

inherit emul-linux-x86

LICENSE="FTL GPL-2 MIT"

KEYWORDS="-* amd64"
IUSE="${IUSE} opengl"

DEPEND=""
RDEPEND="~app-emulation/emul-linux-x86-baselibs-${PV}
	x11-libs/libX11
	opengl? ( app-emulation/emul-linux-x86-opengl )"
