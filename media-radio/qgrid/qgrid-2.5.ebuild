# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/qgrid/qgrid-2.5.ebuild,v 1.3 2005/08/11 00:41:07 killsoft Exp $

inherit kde

DESCRIPTION="Amateur radio grid square calculator"
HOMEPAGE="http://users.telenet.be/on4qz/"
SRC_URI="http://users.telenet.be/on4qz/qgrid/download/${P}.tar.gz"

SLOT="0"
KEYWORDS="x86 ~ppc"
LICENSE="GPL-2"
IUSE=""

need-kde 3
