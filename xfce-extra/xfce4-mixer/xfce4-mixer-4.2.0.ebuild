# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-mixer/xfce4-mixer-4.2.0.ebuild,v 1.6 2005/02/01 17:38:29 bcowan Exp $

DESCRIPTION="Xfce 4 mixer panel plugin"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ppc ~ppc64 sparc x86"
IUSE="alsa"

BZIPPED=1
RDEPEND="~xfce-base/xfce4-panel-${PV}
	alsa? ( media-libs/alsa-lib )"

use alsa && XFCE_CONFIG="--with-sound=alsa"

inherit xfce4