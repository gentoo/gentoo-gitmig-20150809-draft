# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/noatun-noatunmadness/noatun-noatunmadness-3.4.0_beta1.ebuild,v 1.1 2005/01/15 02:24:41 danarmak Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="noatun-plugins/noatunmadness"
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="noatun visualizatin plugin"
KEYWORDS="~x86"
IUSE="svga"

# in case something from kdelibs linked against svgalib,
# we might link against it too. this isn't pretty by any means.
OLDDEPEND="~kde-base/noatun-$PV"
DEPEND="$(deprange-dual $PV $MAXKDEVER kde-base/noatun)"

