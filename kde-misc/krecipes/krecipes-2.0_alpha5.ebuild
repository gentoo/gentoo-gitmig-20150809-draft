# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/krecipes/krecipes-2.0_alpha5.ebuild,v 1.1 2010/01/14 15:28:17 ssuominen Exp $

EAPI=2
# FIXME. What is ca@valencia in po/ ?
KDE_LINGUAS="ca cs da de el en_GB eo es et fr ga gl hi hne is it ja
lt nb nds nl nn pl pt pt_BR ro sk sv tr uk zh_TW"
KDE_DOC_DIRS="doc doc-translations/%lingua_${PN}"
inherit kde4-base

DESCRIPTION="A KDE4 recipe application"
HOMEPAGE="http://krecipes.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P/_/-}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="4"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug +handbook"

DEPEND="dev-libs/soprano"

S=${WORKDIR}/${P/_/-}

DOCS="AUTHORS BUGS ChangeLog README TODO"

src_configure() {
	# -DWITH_Soprano=OFF doesn't compile
	mycmakeargs="${mycmakeargs}
		-DWITH_Soprano=ON"
	kde4-base_src_configure
}
