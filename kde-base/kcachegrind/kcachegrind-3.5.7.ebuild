# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcachegrind/kcachegrind-3.5.7.ebuild,v 1.8 2007/08/11 11:24:50 philantrop Exp $

KMNAME=kdesdk
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE Frontend for Cachegrind"
KEYWORDS="alpha amd64 ppc ppc64 sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

DEPEND="!alpha? ( !sparc? ( !x86-fbsd? ( >=dev-util/valgrind-3.2.0 ) ) )"

RDEPEND="${DEPEND}
	media-gfx/graphviz"
