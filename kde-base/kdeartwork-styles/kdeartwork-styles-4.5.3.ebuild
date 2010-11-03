# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-styles/kdeartwork-styles-4.5.3.ebuild,v 1.1 2010/11/03 16:30:18 scarabeus Exp $

EAPI="3"

KMMODULE="styles"
KMNAME="kdeartwork"
inherit kde4-meta

DESCRIPTION="Extra KWin styles and window decorations"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

KMEXTRA="
	aurorae/
"
