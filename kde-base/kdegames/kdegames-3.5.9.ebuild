# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegames/kdegames-3.5.9.ebuild,v 1.6 2008/05/12 16:16:17 ranger Exp $

EAPI="1"
inherit kde-dist

DESCRIPTION="KDE games (not just solitaire ;-)"

KEYWORDS="alpha ~amd64 ~hppa ia64 ~mips ppc ppc64 sparc ~x86"
IUSE="kdehiddenvisibility"

# For backgrounds in kpat.
RDEPEND="~kde-base/kdebase-${PV}"

# Surprise, surprise... Tests are broken.
RESTRICT="test"
