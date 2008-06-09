# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/potracegui/potracegui-1.3.4.ebuild,v 1.2 2008/06/09 08:17:52 loki_val Exp $

inherit kde

DESCRIPTION="Potracegui is a GUI interface for potrace and autotrace, two programs for tracing bitmapped images"
HOMEPAGE="http://potracegui.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="media-gfx/autotrace
	media-gfx/potrace"
PATCHES=( "${FILESDIR}/${P}-gcc43.patch" )

need-kde 3.3.2
