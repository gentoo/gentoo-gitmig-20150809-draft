# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/konqueror-sidebar/konqueror-sidebar-3.4.0_beta2.ebuild,v 1.1 2005/02/05 11:39:21 danarmak Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="konq-plugins/sidebar"
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="konqueror sidebar plugin"
KEYWORDS="~x86"
IUSE=""
OLDDEPEND="~kde-base/konqueror-$PV ~kde-base/kdeaddons-docs-konq-plugins-3.3.1"
DEPEND="
$(deprange $PV $MAXKDEVER kde-base/konqueror)
$(deprange $PV $MAXKDEVER kde-base/kdeaddons-docs-konq-plugins)"
