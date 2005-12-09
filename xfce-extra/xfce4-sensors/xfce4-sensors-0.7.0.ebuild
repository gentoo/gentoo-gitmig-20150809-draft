# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-sensors/xfce4-sensors-0.7.0.ebuild,v 1.1 2005/12/09 21:52:27 dostrow Exp $

inherit xfce42

DESCRIPTION="Xfce4 panel lm-sensors plugin"
KEYWORDS="~amd64 ~x86 ~ppc"

RDEPEND="sys-apps/lm_sensors"

goodies_plugin