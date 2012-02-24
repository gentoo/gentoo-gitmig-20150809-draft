# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/rsibreak/rsibreak-0.11.ebuild,v 1.4 2012/02/24 14:20:19 phajdan.jr Exp $

EAPI=4
KDE_LINGUAS="ar be ca cs da de el en_GB es et fr ga gl hi hne is it ja km ko lt
ml nb nds nl nn oc pl pt pt_BR ro ru se sk sv tr uk zh_CN zh_TW"
KDE_DOC_DIRS="doc doc-translations/%lingua_${PN}"
KDE_HANDBOOK="optional"

inherit kde4-base

DESCRIPTION="A small utility which bothers you at certain intervals"
HOMEPAGE="http://www.rsibreak.org/"
SRC_URI="http://www.rsibreak.org/files/${P}.tar.bz2"

LICENSE="GPL-2 FDL-1.2"
SLOT="4"
KEYWORDS="amd64 ~ppc x86"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep knotify)
"
