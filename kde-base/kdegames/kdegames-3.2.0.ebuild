# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegames/kdegames-3.2.0.ebuild,v 1.2 2004/02/04 20:31:04 caleb Exp $
inherit kde-dist eutils

DESCRIPTION="KDE games (solitaire :-)"
IUSE=""
KEYWORDS="~x86 ~sparc ~amd64"

DO_NOT_COMPILE="$DO_NOT_COMPILE ktron"
