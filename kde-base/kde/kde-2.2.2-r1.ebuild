# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde/kde-2.2.2-r1.ebuild,v 1.9 2002/10/04 05:40:28 vapier Exp $

DESCRIPTION="KDE $PV - merge this to pull in all non-developer kde-base/* packages"
HOMEPAGE="http://www.kde.org/"

# removed: kdebindings, kdesdk, kdoc since these are developer-only packages
RDEPEND="`echo ~kde-base/kde{libs,base,admin,artwork,games,graphics,multimedia,network,pim,toys,utils,addons}-${PV}`"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"
