# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksvgplugin/ksvgplugin-3.4.0_beta2.ebuild,v 1.1 2005/02/05 11:39:24 danarmak Exp $

KMNAME=kdegraphics
KMNOMODULE=true
KMNODOCS=true
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="SVG viewer kpart"
KEYWORDS="~x86"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/libksvg)"
OLDDEPEND="~kde-base/libksvg"

KMNODOC="true"
KMCOPYLIB="libksvg ksvg"
KMEXTRACTONLY="ksvg/"
KMEXTRA="ksvg/plugin"