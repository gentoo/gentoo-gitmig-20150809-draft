# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-sensors/xfce4-sensors-0.3.0.ebuild,v 1.1 2005/01/08 06:29:42 bcowan Exp $

DESCRIPTION="Xfce4 panel lm-sensors plugin"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

GOODIES_PLUGIN=1
XFCE_RDEPEND="sys-apps/lm-sensors"

inherit xfce4