# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-sensors/xfce4-sensors-0.3.0.ebuild,v 1.3 2005/02/01 17:38:29 bcowan Exp $

DESCRIPTION="Xfce4 panel lm-sensors plugin"
KEYWORDS="~amd64 ~x86"

GOODIES_PLUGIN=1
RDEPEND="sys-apps/lm-sensors"

inherit xfce4