# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde/kde-3.0.2.ebuild,v 1.5 2002/07/25 17:53:21 danarmak Exp $

DESCRIPTION="KDE $PV - merge this to pull in all non-developer kde-base/* packages"
KEYWORDS="x86"
HOMEPAGE="http://www.kde.org/"
# removed: kdebindings, kdesdk, kdoc since these are developer-only packages
RDEPEND=`echo ~kde-base/kde{libs,base,addons,admin,artwork,edu,games,graphics,multimedia,network,pim,toys,utils}-${PV}`
SLOT="3"
