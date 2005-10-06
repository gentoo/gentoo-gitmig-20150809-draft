# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-fsguard/xfce4-fsguard-0.2.0-r2.ebuild,v 1.1 2005/10/06 17:34:34 bcowan Exp $

inherit xfce42

DESCRIPTION="Xfce4 panel plugin that shows free space on mountpoints"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~sparc ~x86"

goodies_plugin
S=${WORKDIR}/${PN}-plugin
