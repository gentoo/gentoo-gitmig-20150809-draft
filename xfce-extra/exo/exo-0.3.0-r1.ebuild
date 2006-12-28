# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/exo/exo-0.3.0-r1.ebuild,v 1.5 2006/12/28 03:32:56 nichoj Exp $

inherit xfce42

DESCRIPTION="Extension library for Xfce"
HOMEPAGE="http://www.os-cillation.com/"
KEYWORDS="~amd64 ~arm ~ia64 ~ppc ppc64 ~sparc ~x86"

RDEPEND="|| ( ( x11-libs/libX11
	x11-libs/libICE
	x11-libs/libSM )
	virtual/x11 )
	>=x11-libs/gtk+-2.4
	>=xfce-base/libxfce4mcs-4.2.2-r1
	>=xfce-base/libxfcegui4-4.2.0"
DEPEND="${RDEPEND}
	|| ( ( x11-libs/libX11
	x11-libs/libXt )
	virtual/x11 )"

bzipped
goodies

