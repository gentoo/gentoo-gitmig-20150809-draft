# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde/kde-3.0.ebuild,v 1.2 2002/04/09 05:29:08 drobbins Exp $

DESCRIPTION="KDE 3.0 - merge this to pull in all non-developer kde-base/* packages"
HOMEPAGE="http://www.kde.org/"
set -o noglob
# removed: kdebindings, kdesdk, kdoc since these are developer-only packages
RDEPEND=`echo ~kde-base/kde{libs,base,addons,admin,artwork,edu,games,graphics,multimedia,network,pim,toys,utils}-${PV}`

