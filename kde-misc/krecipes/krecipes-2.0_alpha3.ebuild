# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/krecipes/krecipes-2.0_alpha3.ebuild,v 1.2 2009/10/24 09:55:59 ssuominen Exp $

EAPI=2
KDE_MINIMAL=4.2
KDE_LINGUAS="cs da de el en_GB es et fr ga gl hi hne is it ja lt nb nds nl nn
pl pt pt_BR ro sk sv tr uk zh_TW"
KDE_DOC_DIRS="doc doc-translations/%lingua_${PN}"

inherit kde4-base

DESCRIPTION="A KDE4 recipe application"
HOMEPAGE="http://krecipes.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P/_/-}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="4"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug +handbook"

# -DWITH_Soprano=OFF fails to link. Forcing semantic-desktop.
DEPEND=">=kde-base/kdelibs-${KDE_MINIMAL}[semantic-desktop]
	!${CATEGORY}/${PN}:0"

S=${WORKDIR}/${P/_/-}
