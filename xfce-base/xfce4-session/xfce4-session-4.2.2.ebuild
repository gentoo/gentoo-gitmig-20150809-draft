# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4-session/xfce4-session-4.2.2.ebuild,v 1.4 2005/07/08 17:41:19 gustavoz Exp $

DESCRIPTION="Xfce 4 session manager"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ppc ppc64 sparc x86"

RDEPEND="~xfce-base/xfce-utils-${PV}"
SINGLE_MAKE=1

inherit xfce4
