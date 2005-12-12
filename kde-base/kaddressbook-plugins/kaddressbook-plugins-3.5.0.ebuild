# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kaddressbook-plugins/kaddressbook-plugins-3.5.0.ebuild,v 1.4 2005/12/12 16:47:23 josejx Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA=kaddressbook-plugins/
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Plugins for KAB"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/kaddressbook)"

