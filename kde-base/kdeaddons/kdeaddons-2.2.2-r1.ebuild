# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaddons/kdeaddons-2.2.2-r1.ebuild,v 1.7 2002/10/04 05:40:44 vapier Exp $
inherit kde-dist

DESCRIPTION="KDE $PV: addons - applets, plugins..."
KEYWORDS="x86 sparc sparc64"

newdepend "~kde-base/kdebase-${PV}
	~kde-base/kdenetwork-${PV}
	~kde-base/kdemultimedia-${PV}
	>=media-libs/libsdl-1.2"

