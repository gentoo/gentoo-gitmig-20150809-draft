# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/konqueror-rellinks/konqueror-rellinks-3.4.0_beta1.ebuild,v 1.1 2005/01/15 02:24:36 danarmak Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="konq-plugins/rellinks"
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KHTML plugin: Document Relations (back/forward/up browsing for sites which have generated page-per-chapter layout)"
KEYWORDS="~x86"
IUSE=""
OLDDEPEND="~kde-base/konqueror-$PV ~kde-base/kdeaddons-docs-konq-plugins-3.3.1"
DEPEND="
$(deprange-dual $PV $MAXKDEVER kde-base/konqueror)
$(deprange-dual $PV $MAXKDEVER kde-base/kdeaddons-docs-konq-plugins)"
