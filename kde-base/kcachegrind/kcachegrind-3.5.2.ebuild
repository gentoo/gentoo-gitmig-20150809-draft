# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcachegrind/kcachegrind-3.5.2.ebuild,v 1.11 2006/12/01 18:57:33 flameeyes Exp $

KMNAME=kdesdk
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE Frontend for Cachegrind"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
IUSE="kdehiddenvisibility"

DEPEND="x86? ( >=dev-util/valgrind-3.2.0 )"

RDEPEND="${DEPEND}
	media-gfx/graphviz"
