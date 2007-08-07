# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegames/kdegames-3.5.7.ebuild,v 1.3 2007/08/07 19:29:55 josejx Exp $

inherit kde-dist

DESCRIPTION="KDE games (not just solitaire ;-)"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ppc ~ppc64 sparc ~x86"
IUSE="kdehiddenvisibility"

# For backgrounds in kpat.
RDEPEND="~kde-base/kdebase-${PV}"
