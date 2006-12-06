# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-genmon/xfce4-genmon-3.0.ebuild,v 1.1 2006/12/06 05:04:19 nichoj Exp $

inherit xfce44

xfce44_beta
xfce44_goodies_panel_plugin

DESCRIPTION="Xfce4 panel generic monitor plugin"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

DEPEND="xfce-extra/xfce4-dev-tools"

# FIXME this really shouldn't need to be regenerated, distfile should come ready
# to go
src_compile() {
	xdt-autogen ${XFCE_CONFIG} || die
	emake ${JOBS} || die
}
