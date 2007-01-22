# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-icon-theme/xfce4-icon-theme-4.4.0.ebuild,v 1.1 2007/01/22 02:15:39 nichoj Exp $

inherit xfce44

xfce44

DESCRIPTION="Xfce4 icon theme"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
RDEPEND="x11-themes/hicolor-icon-theme"

xfce44_core_package
