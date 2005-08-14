# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-sensors/xfce4-sensors-0.6.1.ebuild,v 1.1 2005/08/14 22:41:13 bcowan Exp $

DESCRIPTION="Xfce4 panel lm-sensors plugin"
KEYWORDS="~amd64 ~x86 ~ppc"

GOODIES_PLUGIN=1
RDEPEND="sys-apps/lm_sensors"

inherit xfce4