# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/skanlite/skanlite-0.4-r1.ebuild,v 1.3 2010/06/28 06:13:48 fauli Exp $

EAPI=2

KDE_MINIMAL=4.4

KDE_LINGUAS="be ca ca@valencia cs da de el en_GB eo es et fr ga gl hr is it ja
km ko lt lv nb nds nl nn pa pl pt pt_BR ro ru sk sv tr uk wa zh_CN zh_TW"
KDE_DOC_DIRS="doc doc-translations/%lingua_${PN}"

inherit kde4-base

KDE_VERSION=4.4.0
MY_P=${P}-kde${KDE_VERSION}

DESCRIPTION="KDE image scanning application"
HOMEPAGE="http://www.kde.org/"
SRC_URI="mirror://kde/stable/${KDE_VERSION}/src/extragear/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="amd64 x86"
IUSE="debug +handbook"

DEPEND=">=kde-base/libksane-${KDE_MINIMAL}
	!${CATEGORY}/${PN}:0"

S=${WORKDIR}/${MY_P}
