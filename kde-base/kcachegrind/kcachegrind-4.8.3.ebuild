# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcachegrind/kcachegrind-4.8.3.ebuild,v 1.4 2012/05/24 08:21:55 ago Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kdesdk"
inherit kde4-meta

DESCRIPTION="KDE Frontend for Cachegrind"
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	media-gfx/graphviz
"
