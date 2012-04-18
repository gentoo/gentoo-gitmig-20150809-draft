# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/killbots/killbots-4.8.1.ebuild,v 1.3 2012/04/18 21:18:42 maekke Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kdegames"
inherit kde4-meta

DESCRIPTION="Kill the bots or they kill you!"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

# Tests hang, last checked in 4.3.3
RESTRICT="test"
