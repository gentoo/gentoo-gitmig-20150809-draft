# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-kwin-styles/kdeartwork-kwin-styles-3.5.0.ebuild,v 1.1 2005/11/22 22:14:00 danarmak Exp $

KMMODULE=kwin-styles
KMNAME=kdeartwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Window styles for kde"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
$(deprange-dual $PV $MAXKDEVER kde-base/kwin)"

