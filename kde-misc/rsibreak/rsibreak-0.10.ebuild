# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/rsibreak/rsibreak-0.10.ebuild,v 1.4 2010/06/24 17:27:38 ssuominen Exp $

EAPI=2
KDE_LINGUAS="ar be ca cs da de el en_GB es et fr ga gl hi hne is it ja km ko lt
ml nb nds nl nn oc pl pt pt_BR ro ru se sk sv tr uk zh_CN zh_TW"
KDE_DOC_DIRS="doc doc-translations/%lingua_${PN}"

inherit kde4-base

DESCRIPTION="A small utility which bothers you at certain intervals"
HOMEPAGE="http://www.rsibreak.org/"
SRC_URI="http://www.rsibreak.org/files/${P}.tar.bz2"

LICENSE="GPL-2 FDL-1.2"
SLOT="4"
KEYWORDS="amd64 ~ppc ~x86"
IUSE="debug +handbook"

PATCHES=( "${FILESDIR}/${P}-gcc45.patch" )
