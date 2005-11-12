# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kicker-applets/kicker-applets-3.5.0_rc1.ebuild,v 1.1 2005/11/12 15:49:29 danarmak Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="kicker-applets doc/kicker-applets"
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="kicker applets"
KEYWORDS="~amd64 ~x86"
IUSE="xmms"
DEPEND="xmms? ( media-sound/xmms )
$(deprange-dual $PV $MAXKDEVER kde-base/kicker)"

myconf="$(use_with xmms)"
