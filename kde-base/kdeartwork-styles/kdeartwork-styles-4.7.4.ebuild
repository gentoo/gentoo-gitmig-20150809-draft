# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-styles/kdeartwork-styles-4.7.4.ebuild,v 1.3 2012/01/16 21:56:31 ago Exp $

EAPI=4

KMMODULE="styles"
KMNAME="kdeartwork"
inherit kde4-meta

DESCRIPTION="Extra KWin styles and window decorations"
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

add_blocker kwin '<4.5.67'

DEPEND="
		$(add_kdebase_dep kwin)
"
RDEPEND="${DEPEND}"

KMEXTRA="
	aurorae/
	kwin-styles/
"
