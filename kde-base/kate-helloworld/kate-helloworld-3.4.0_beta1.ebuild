# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kate-helloworld/kate-helloworld-3.4.0_beta1.ebuild,v 1.1 2005/01/15 02:24:27 danarmak Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="kate/helloworld"
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Hello World sample plugin for kate"
KEYWORDS="~x86"
IUSE=""
DEPEND="$(deprange-dual $PV $MAXKDEVER kde-base/kate)
$(deprange-dual $PV $MAXKDEVER kde-base/kdeaddons-docs-kate-plugins)"
OLDDEPEND="~kde-base/kate-$PV ~kde-base/kdeaddons-docs-kate-plugins-$PV"
