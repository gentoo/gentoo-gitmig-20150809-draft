# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksvg/ksvg-3.4.0_beta2-r1.ebuild,v 1.1 2005/02/11 15:51:17 danarmak Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="SVG viewer library and embeddable kpart"
KEYWORDS="~x86"
IUSE=""
DEPEND="!=kde-base/libksvg-$SLOT* !=kde-base/ksvplugin-$SLOT*" # old ebuilds replaced by this one
