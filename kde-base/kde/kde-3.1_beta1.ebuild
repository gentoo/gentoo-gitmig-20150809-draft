# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde/kde-3.1_beta1.ebuild,v 1.2 2002/08/30 15:42:57 danarmak Exp $

DESCRIPTION="KDE $PV - merge this to pull in all non-developer kde-base/* packages"
HOMEPAGE="http://www.kde.org/"
# removed: kdebindings, kdesdk, kdoc since these are developer-only packages
RDEPEND=`echo ~kde-base/kde{libs,base,addons,admin,artwork,edu,games,graphics,multimedia,network,pim,toys,utils}-${PV}`

SLOT="3.1"
LICENSE="GPL-2"
KEYWORDS="x86"
