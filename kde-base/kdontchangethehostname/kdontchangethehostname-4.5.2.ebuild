# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdontchangethehostname/kdontchangethehostname-4.5.2.ebuild,v 1.1 2010/10/06 09:17:37 alexxy Exp $

EAPI="3"

KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="Tool to inform KDE about a change in hostname"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

# moved from kdelibs
add_blocker kdelibs 4.4.68
