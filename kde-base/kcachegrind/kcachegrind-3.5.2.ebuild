# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcachegrind/kcachegrind-3.5.2.ebuild,v 1.1 2006/03/22 20:14:57 danarmak Exp $

KMNAME=kdesdk
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE Frontend for Cachegrind"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="x86? ( dev-util/callgrind )"

RDEPEND="${DEPEND}
	media-gfx/graphviz"
