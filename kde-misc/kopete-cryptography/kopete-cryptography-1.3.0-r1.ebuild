# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kopete-cryptography/kopete-cryptography-1.3.0-r1.ebuild,v 1.1 2009/11/09 11:36:32 ssuominen Exp $

EAPI=2
KDE_LINGUAS="ar be cs da de el en_GB es et fr ga gl hi hne is it ja km lt nb
nds nl nn oc pa pt pt_BR ro sk sv tr uk zh_CN zh_TW"
KDE_DOC_DIRS="doc doc-translations/%lingua_${PN}"
inherit kde4-base

KDE_VERSION=4.3.3
MY_P=${P}-kde${KDE_VERSION}

DESCRIPTION="Cryptography for Kopete instant messenger"
HOMEPAGE="http://www.kde.org/"
SRC_URI="mirror://kde/stable/${KDE_VERSION}/src/extragear/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug +handbook"

DEPEND=">=kde-base/kopete-${KDE_MINIMAL}
	>=kde-base/libkdepim-${KDE_MINIMAL}
	>=kde-base/libkleo-${KDE_MINIMAL}
	!${CATEGORY}/${PN}:0"

S=${WORKDIR}/${MY_P}
