# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gamazons/gamazons-0.83.ebuild,v 1.2 2005/02/22 11:56:26 dholm Exp $

inherit gnome2

DESCRIPTION="A chess/go hybrid"
HOMEPAGE="http://www.yorgalily.org/gamazons/"
SRC_URI="http://www.yorgalily.org/gamazons/src/$P.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND=">=gnome-base/libgnomeui-2"
