# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegames/kdegames-3.5.6.ebuild,v 1.3 2007/01/25 18:56:02 flameeyes Exp $

inherit kde-dist

DESCRIPTION="KDE games (not just solitaire ;-)"

KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="kdehiddenvisibility"

# For backgrounds in kpat.
RDEPEND="~kde-base/kdebase-${PV}"
