# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcachegrind/kcachegrind-3.5.0.ebuild,v 1.1 2005/11/22 22:13:58 danarmak Exp $

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
