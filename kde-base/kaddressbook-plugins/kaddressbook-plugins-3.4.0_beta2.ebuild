# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kaddressbook-plugins/kaddressbook-plugins-3.4.0_beta2.ebuild,v 1.2 2005/02/27 20:21:30 danarmak Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA=kaddressbook-plugins/
MAXKDEVER=3.4.0_rc1
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Plugins for KAB"
KEYWORDS="~x86"
IUSE=""
DEPEND="$(deprange $PV 3.4.0_rc1 kde-base/kaddressbook)"
OLDDEPEND="~kde-base/kaddressbook-$PV"
