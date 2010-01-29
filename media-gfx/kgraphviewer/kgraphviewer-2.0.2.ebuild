# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/kgraphviewer/kgraphviewer-2.0.2.ebuild,v 1.2 2010/01/29 14:14:33 ssuominen Exp $

EAPI=2
KDE_LINGUAS="ar be bg cs da de el en_GB es et fr ga gl hi hne is it ja km ku lt
mai nb nds nl nn pa pl pt pt_BR ro se sk sv th tr uk vi zh_CN zh_TW"
inherit kde4-base

KVER=4.3.3

DESCRIPTION="A graphviz dot graph file viewer for KDE"
HOMEPAGE="http://www.kde.org/"
SRC_URI="mirror://kde/stable/${KVER}/src/extragear/${P}-kde${KVER}.tar.bz2"

LICENSE="GPL-2 FDL-1.2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug +handbook"

RDEPEND="sys-libs/zlib
	media-gfx/graphviz
	>=kde-base/kdepimlibs-${KDE_MINIMAL}"
DEPEND="${RDEPEND}
	>=dev-libs/boost-1.38"

S=${WORKDIR}/${P}-kde${KVER}

DOCS="AUTHORS ChangeLog README TODO"
