# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaddons/kdeaddons-2.2.2-r1.ebuild,v 1.11 2003/07/16 16:17:22 pvdabeel Exp $
inherit kde-dist

IUSE=""
DESCRIPTION="KDE $PV: addons - applets, plugins..."
KEYWORDS="x86 sparc ppc"

newdepend "~kde-base/kdebase-${PV}
	~kde-base/kdenetwork-${PV}
	~kde-base/kdemultimedia-${PV}
	>=media-libs/libsdl-1.2"

