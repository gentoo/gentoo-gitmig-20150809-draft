# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4-panel/xfce4-panel-4.2.0.ebuild,v 1.8 2005/03/12 20:13:37 vapier Exp $

DESCRIPTION="Xfce 4 panel"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ~ppc64 sparc x86"

BZIPPED=1
RDEPEND="~xfce-base/xfce-mcs-plugins-${PV}"

inherit xfce4
