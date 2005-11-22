# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegames/kdegames-3.5.0.ebuild,v 1.1 2005/11/22 22:14:01 danarmak Exp $

inherit kde-dist

DESCRIPTION="KDE games (not just solitaire ;-)"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE=""

# For backgrounds in kpat.
RDEPEND="~kde-base/kdebase-${PV}"
