# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfwm4/xfwm4-4.2.2.ebuild,v 1.6 2005/07/11 17:41:27 killerfox Exp $

DESCRIPTION="Xfce 4 window manager"
KEYWORDS="~alpha ~amd64 arm hppa ~ia64 ~mips ppc ppc64 sparc x86"

RDEPEND="~xfce-base/xfce-mcs-manager-${PV}"
XFCE_CONFIG="--enable-randr --enable-compositor"

inherit xfce4
