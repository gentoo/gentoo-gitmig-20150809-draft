# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcachegrind/kcachegrind-3.5.0_beta2.ebuild,v 1.2 2005/10/22 06:33:07 halcy0n Exp $

KMNAME=kdesdk
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE Frontend for Cachegrind"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x86? ( dev-util/callgrind )"

RDEPEND="${DEPEND}
	media-gfx/graphviz"
