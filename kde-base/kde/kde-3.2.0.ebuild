# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde/kde-3.2.0.ebuild,v 1.3 2004/02/10 07:03:39 pylon Exp $

IUSE=""
KEYWORDS="~x86 ~sparc ~amd64 ppc"
DESCRIPTION="KDE 3.2 - merge this to pull in all non-developer kde-base/* packages"
HOMEPAGE="http://www.kde.org/"
# removed: kdebindings, kdesdk, kdoc since these are developer-only packages
RDEPEND="`echo ~kde-base/kde{libs,base,addons,admin,artwork,edu,games,graphics,multimedia,network,pim,toys,utils,accessibility}-${PV}`"

LICENSE="GPL-2"

SLOT="3.2"
