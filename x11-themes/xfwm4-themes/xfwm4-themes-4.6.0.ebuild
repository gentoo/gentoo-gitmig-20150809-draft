# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/xfwm4-themes/xfwm4-themes-4.6.0.ebuild,v 1.9 2009/07/27 17:43:06 nixnut Exp $

inherit xfce4

xfce4_core

DESCRIPTION="Window manager themes"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""
RESTRICT="binchecks strip"

RDEPEND=">=xfce-base/xfwm4-${XFCE_VERSION}"

DOCS="AUTHORS ChangeLog NEWS README TODO"
