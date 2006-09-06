# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kicker-applets/kicker-applets-3.5.4.ebuild,v 1.2 2006/09/06 22:39:41 flameeyes Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="kicker-applets doc/kicker-applets"
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="kicker applets"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="xmms"
DEPEND="xmms? ( media-sound/xmms )
$(deprange-dual $PV $MAXKDEVER kde-base/kicker)"

src_compile() {
	myconf="$(use_with xmms)"
	kde-meta_src_compile
}
