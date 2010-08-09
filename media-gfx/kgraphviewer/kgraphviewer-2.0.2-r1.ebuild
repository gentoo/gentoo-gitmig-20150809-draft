# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/kgraphviewer/kgraphviewer-2.0.2-r1.ebuild,v 1.2 2010/08/09 16:14:13 reavertm Exp $

EAPI=2

KDE_LINGUAS="ar be bg ca ca@valencia cs da de el en_GB eo es et fr ga gl hi hne
hr is it ja km ku lt mai nb nds nl nn pa pl pt pt_BR ro se sk sv th tr uk vi
zh_CN zh_TW"
inherit kde4-base

KDE_VERSION=4.4.0

DESCRIPTION="A graphviz dot graph file viewer for KDE"
HOMEPAGE="http://www.kde.org/"
SRC_URI="mirror://kde/stable/${KDE_VERSION}/src/extragear/${P}-kde${KDE_VERSION}.tar.bz2"

LICENSE="GPL-2 FDL-1.2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug +handbook"

RDEPEND="
	>=kde-base/kdepimlibs-${KDE_MINIMAL}
	media-gfx/graphviz
	sys-libs/zlib
"
DEPEND="${RDEPEND}
	>=dev-libs/boost-1.38
"

S=${WORKDIR}/${P}-kde${KDE_VERSION}
