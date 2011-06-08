# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/klickety/klickety-4.6.3.ebuild,v 1.2 2011/06/08 22:40:48 tomka Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kdegames"
inherit kde4-meta

DESCRIPTION="A KDE game almost the same as ksame, but a bit different."
KEYWORDS="~amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

# Replaced ksame around 4.5.74
add_blocker ksame
