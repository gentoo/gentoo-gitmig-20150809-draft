# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-mixer/xfce4-mixer-4.2.0.ebuild,v 1.4 2005/01/29 20:16:34 pylon Exp $

DESCRIPTION="Xfce 4 mixer panel plugin"
KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ~mips ppc ~ppc64 sparc x86"
IUSE="alsa"

BZIPPED=1
XRDEPEND="alsa? ( media-libs/alsa-lib )
	>=xfce-base/xfce4-panel-${PV}"
use alsa && XFCE_CONFIG="--with-sound=alsa"

inherit xfce4