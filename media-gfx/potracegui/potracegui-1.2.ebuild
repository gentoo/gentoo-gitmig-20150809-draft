# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/potracegui/potracegui-1.2.ebuild,v 1.5 2007/02/04 08:22:23 mr_bones_ Exp $

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
need-kde 3.3.2
