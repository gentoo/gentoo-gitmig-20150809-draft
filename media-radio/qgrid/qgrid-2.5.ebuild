# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/qgrid/qgrid-2.5.ebuild,v 1.2 2005/02/16 05:24:56 killsoft Exp $

inherit kde

DESCRIPTION="Amateur radio grid square calculator"
HOMEPAGE="http://users.telenet.be/on4qz/"
SRC_URI="http://users.telenet.be/on4qz/download/${P}.tar.gz"

SLOT="0"
KEYWORDS="x86 ~ppc"
LICENSE="GPL-2"
IUSE=""

need-kde 3
