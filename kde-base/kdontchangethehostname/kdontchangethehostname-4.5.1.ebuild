# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdontchangethehostname/kdontchangethehostname-4.5.1.ebuild,v 1.3 2010/09/14 18:02:30 josejx Exp $

EAPI="3"

KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="Tool to inform KDE about a change in hostname"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

# moved from kdelibs
add_blocker kdelibs 4.4.68
