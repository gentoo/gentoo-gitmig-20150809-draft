# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-xmms/xfce4-xmms-0.3.1-r1.ebuild,v 1.1 2005/10/06 07:56:10 bcowan Exp $

inherit xfce42

DESCRIPTION="Xfce panel xmms controller"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~sparc ~x86"
RDEPEND="|| ( ( x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXi )
	virtual/x11 )"

bzipped
goodies_plugin