# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/klickety/klickety-4.6.0.ebuild,v 1.2 2011/01/30 09:14:56 xarthisius Exp $

EAPI="3"

KDE_HANDBOOK="optional"
KMNAME="kdegames"
inherit kde4-meta

DESCRIPTION="A KDE game almost the same as ksame, but a bit different."
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug"

# Replaced ksame around 4.5.74
add_blocker ksame
