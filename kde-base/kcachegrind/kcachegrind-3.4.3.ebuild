# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcachegrind/kcachegrind-3.4.3.ebuild,v 1.6 2005/12/10 07:37:32 chriswhite Exp $

KMNAME=kdesdk
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE Frontend for Cachegrind"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="x86? ( dev-util/callgrind )"

RDEPEND="${DEPEND}
	media-gfx/graphviz"
