# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/rocs/rocs-4.4.0.ebuild,v 1.1 2010/02/09 00:21:52 alexxy Exp $

EAPI="2"

KMNAME="kdeedu"
inherit kde4-meta

DESCRIPTION="KDE4 interface to work with Graph Theory"
KEYWORDS="~amd64 ~x86"
IUSE="debug +handbook"

DEPEND="
	>=dev-cpp/eigen-2.0.3:2
"
RDEPEND=""
