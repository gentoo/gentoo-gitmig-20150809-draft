# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfdesktop/xfdesktop-4.2.0.ebuild,v 1.5 2005/01/31 15:31:36 lanius Exp $

DESCRIPTION="Xfce 4 desktop manager"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ppc ~ppc64 sparc x86"

BZIPPED=1
XRDEPEND=">=xfce-base/xfce4-panel-${PV}"

inherit xfce4