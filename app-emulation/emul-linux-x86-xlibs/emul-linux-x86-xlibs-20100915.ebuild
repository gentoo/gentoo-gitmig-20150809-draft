# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-xlibs/emul-linux-x86-xlibs-20100915.ebuild,v 1.2 2010/10/04 12:50:23 hwoarang Exp $

inherit emul-linux-x86

LICENSE="BSD FTL GPL-2 MIT MOTIF"

KEYWORDS="-* amd64"
IUSE="opengl"

DEPEND=""
RDEPEND="~app-emulation/emul-linux-x86-baselibs-${PV}
	x11-libs/libX11
	opengl? ( app-emulation/emul-linux-x86-opengl )"
