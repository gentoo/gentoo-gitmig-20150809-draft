# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-mixer/xfce4-mixer-4.2.1.ebuild,v 1.2 2005/03/24 03:43:10 dostrow Exp $

DESCRIPTION="Xfce 4 mixer panel plugin"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="alsa"

RDEPEND="~xfce-base/xfce4-panel-4.2.1.1
	alsa? ( media-libs/alsa-lib )"

use alsa && XFCE_CONFIG="--with-sound=alsa"

inherit xfce4
