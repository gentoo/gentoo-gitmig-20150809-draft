# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde/kde-3.2.1.ebuild,v 1.1 2004/03/09 17:50:31 caleb Exp $

DESCRIPTION="KDE 3.2 - merge this to pull in all non-developer kde-base/* packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.2"
KEYWORDS="~x86 ~ppc ~hppa ~sparc ~amd64 ~alpha ~ia64"

# removed: kdebindings, kdesdk, kdoc since these are developer-only packages
RDEPEND="`echo ~kde-base/kde{libs,base,addons,admin,artwork,edu,games,graphics,multimedia,network,pim,toys,utils,accessibility}-${PV}`"
