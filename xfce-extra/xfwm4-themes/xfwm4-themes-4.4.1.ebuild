# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfwm4-themes/xfwm4-themes-4.4.1.ebuild,v 1.2 2007/05/15 18:04:01 gustavoz Exp $

inherit xfce44

XFCE_VERSION=4.4.1
xfce44

DESCRIPTION="Window manager themes"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 sparc ~x86 ~x86-fbsd"
RESTRICT="binchecks strip"

RDEPEND=">=xfce-base/xfwm4-${XFCE_MASTER_VERSION}"
DEPEND=""

DOCS="AUTHORS ChangeLog NEWS README TODO"

xfce44_core_package
