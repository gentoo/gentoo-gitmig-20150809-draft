# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-trigger-launcher/xfce4-trigger-launcher-4.2.3.ebuild,v 1.1 2005/12/09 21:27:45 dostrow Exp $

inherit xfce42

DESCRIPTION="Xfce 4 trigger launcher panel plugin"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

RDEPEND="~xfce-base/xfce4-panel-${PV}"

core_package