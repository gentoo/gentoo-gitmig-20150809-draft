# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-icon-theme/xfce4-icon-theme-4.3.90.2.ebuild,v 1.2 2006/07/14 20:19:07 bcowan Exp $

inherit xfce44

xfce44_beta

DESCRIPTION="Xfce 4 icon theme"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

xfce44_core_package

RDEPEND="x11-themes/hicolor-icon-theme"
