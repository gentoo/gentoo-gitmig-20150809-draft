# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-modemlights/xfce4-modemlights-0.1.1-r1.ebuild,v 1.1 2005/10/06 07:48:26 bcowan Exp $

inherit xfce42

DESCRIPTION="Xfce4 panel modem lights plugin"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
DEPEND="${RDEPEND}
	|| ( x11-libs/libXt virtual/x11 )"

goodies_plugin
