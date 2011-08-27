# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/rocs/rocs-4.7.0.ebuild,v 1.3 2011/08/27 07:44:36 dilfridge Exp $

EAPI=4

KDE_HANDBOOK="optional"
KDE_SCM="git"
inherit kde4-base

DESCRIPTION="KDE4 interface to work with Graph Theory"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="dev-libs/boost"
DEPEND="
	${RDEPEND}
	>=dev-cpp/eigen-2.0.3:2
"

RESTRICT="test"
# bug 376909
