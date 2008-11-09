# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcachegrind/kcachegrind-4.1.3.ebuild,v 1.1 2008/11/09 01:23:23 scarabeus Exp $

EAPI="2"

KMNAME=kdesdk
inherit kde4-meta

DESCRIPTION="KDE Frontend for Cachegrind"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

RDEPEND="${RDEPEND} media-gfx/graphviz"
