# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksvg/ksvg-3.4.1.ebuild,v 1.6 2005/07/08 04:03:39 weeve Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="SVG viewer library and embeddable kpart"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="media-libs/libart_lgpl
	media-libs/lcms
	dev-libs/fribidi"
