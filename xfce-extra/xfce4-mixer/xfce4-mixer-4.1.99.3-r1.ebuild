# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-mixer/xfce4-mixer-4.1.99.3-r1.ebuild,v 1.1 2005/01/06 21:45:46 bcowan Exp $

DESCRIPTION="Xfce 4 mixer panel plugin"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="alsa"

XFCE_RDEPEND="alsa? ( media-libs/alsa-lib )
	    >=xfce-base/xfce4-panel-${PV}-r1"
XFCE_CONFIG="$(use_enable alsa --with-sound=alsa)"

inherit xfce4
