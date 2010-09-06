# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/killbots/killbots-4.5.1.ebuild,v 1.1 2010/09/06 00:37:49 tampakrap Exp $

EAPI="3"

KDE_HANDBOOK=1
KMNAME="kdegames"
inherit kde4-meta

DESCRIPTION="Kill the bots or they kill you!"
KEYWORDS=""
IUSE="debug"

# Tests hang, last checked in 4.3.3
RESTRICT="test"
