# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-fsguard/xfce4-fsguard-0.2.0-r1.ebuild,v 1.2 2005/01/18 23:53:34 bcowan Exp $

DESCRIPTION="Xfce4 panel plugin that shows free space on mountpoints"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~sparc ~x86"

XFCE_S=${WORKDIR}/${PN}-plugin
GOODIES_PLUGIN=1

inherit xfce4
