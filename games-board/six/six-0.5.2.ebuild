# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/six/six-0.5.2.ebuild,v 1.6 2006/05/31 15:49:27 flameeyes Exp $

ARTS_REQUIRED="yes"
inherit kde

DESCRIPTION="A Hex playing program for KDE"
HOMEPAGE="http://six.retes.hu/"
SRC_URI="http://six.retes.hu/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc ~sparc x86"
IUSE=""

need-kde 3
