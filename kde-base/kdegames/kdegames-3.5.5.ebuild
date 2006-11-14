# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegames/kdegames-3.5.5.ebuild,v 1.3 2006/11/13 23:57:10 kugelfang Exp $

inherit kde-dist

DESCRIPTION="KDE games (not just solitaire ;-)"

KEYWORDS="~alpha amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc x86"
IUSE=""

# For backgrounds in kpat.
RDEPEND="~kde-base/kdebase-${PV}"
