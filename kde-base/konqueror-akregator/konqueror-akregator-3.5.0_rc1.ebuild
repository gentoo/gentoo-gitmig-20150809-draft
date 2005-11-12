# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/konqueror-akregator/konqueror-akregator-3.5.0_rc1.ebuild,v 1.1 2005/11/12 15:49:31 danarmak Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="konq-plugins/akregator"
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="konqueror's akregator plugin"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="$(deprange-dual $PV $MAXKDEVER kde-base/konqueror)"
RDEPEND="${DEPEND}
$(deprange 3.5_beta1 $MAXKDEVER kde-base/kdeaddons-docs-konq-plugins)
$(deprange-dual $PV $MAXKDEVER kde-base/akregator)"
