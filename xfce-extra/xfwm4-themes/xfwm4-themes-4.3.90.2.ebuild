# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfwm4-themes/xfwm4-themes-4.3.90.2.ebuild,v 1.1 2006/07/10 18:25:45 bcowan Exp $

inherit xfce44

xfce44_beta

DESCRIPTION="Xfce 4 window manager themes"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

RDEPEND="~xfce-base/xfwm4-${PV}"

xfce44_core_package
