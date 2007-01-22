# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfwm4-themes/xfwm4-themes-4.4.0.ebuild,v 1.1 2007/01/22 02:16:45 nichoj Exp $

inherit xfce44

xfce44

DESCRIPTION="Xfce4 window manager themes"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

RDEPEND=">=xfce-base/xfwm4-${PV}"

xfce44_core_package
