# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libksvg/libksvg-3.4.0_beta1.ebuild,v 1.2 2005/02/11 15:10:19 danarmak Exp $

KMNAME=kdegraphics
KMMODULE=ksvg
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE SVG library"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-libs/fribidi !kde-base/ksvg"
KMNODOC="true"
KMEXTRACTONLY="ksvg/plugin/"