# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksvg/ksvg-3.4.0.ebuild,v 1.4 2005/04/03 17:08:28 greg_g Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="SVG viewer library and embeddable kpart"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
IUSE=""

DEPEND="media-libs/libart_lgpl
	media-libs/lcms
	dev-libs/fribidi"
