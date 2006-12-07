# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-icon-theme/xfce4-icon-theme-4.3.99.2.ebuild,v 1.2 2006/12/07 02:33:19 beu Exp $

inherit xfce44

xfce44_beta

DESCRIPTION="Xfce 4 icon theme"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
RDEPEND="x11-themes/hicolor-icon-theme"

xfce44_core_package
