# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce-mcs-manager/xfce-mcs-manager-4.2.0.ebuild,v 1.5 2005/01/31 15:24:11 lanius Exp $

DESCRIPTION="Xfce 4 mcs manager"
LICENSE="LGPL-2"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ppc ~ppc64 sparc x86"

BZIPPED=1
XRDEPEND=">=xfce-base/libxfce4mcs-${PV}"

inherit xfce4
