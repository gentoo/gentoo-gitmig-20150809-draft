# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-appfinder/xfce4-appfinder-4.2.0.ebuild,v 1.7 2005/02/08 23:57:47 kloeri Exp $

DESCRIPTION="Xfce 4 application finder"
KEYWORDS="alpha amd64 ~arm hppa ~ia64 ~mips ppc ~ppc64 sparc x86"

BZIPPED=1
RDEPEND="~xfce-base/libxfce4mcs-${PV}"

inherit xfce4