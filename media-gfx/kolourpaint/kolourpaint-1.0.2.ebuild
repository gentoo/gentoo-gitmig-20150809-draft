# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/kolourpaint/kolourpaint-1.0.2.ebuild,v 1.3 2004/08/23 13:32:09 carlo Exp $

inherit kde

DESCRIPTION="A simple paint program for KDE"
HOMEPAGE="http://kolourpaint.sourceforge.net"
SRC_URI="mirror://sourceforge/kolourpaint/${P}.tar.bz2"
LICENSE="BSD"
SLOT="0"
IUSE=""
KEYWORDS="~x86 ~amd64 ~ppc"

DEPEND="!>=kde-base/kdegraphics-3.3"
RDEPEND="!>=kde-base/kdegraphics-3.3"
need-kde 3