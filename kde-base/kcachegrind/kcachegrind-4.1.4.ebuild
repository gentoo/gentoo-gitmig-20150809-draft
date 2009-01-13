# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcachegrind/kcachegrind-4.1.4.ebuild,v 1.1 2009/01/13 21:21:42 alexxy Exp $

EAPI="2"

KMNAME=kdesdk
inherit kde4-meta

DESCRIPTION="KDE Frontend for Cachegrind"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug htmlhandbook"

RDEPEND="${RDEPEND} media-gfx/graphviz"
