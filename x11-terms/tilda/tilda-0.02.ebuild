# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/tilda/tilda-0.02.ebuild,v 1.2 2005/07/10 00:41:54 swegener Exp $

DESCRIPTION="A drop down terminal, similar to the consoles in first person shooters"
HOMEPAGE="http://tilda.sourceforge.net"
SRC_URI="mirror://sourceforge/tilda/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND="x11-libs/vte
		x11-misc/xbindkeys
		x11-misc/devilspie
		virtual/x11"

src_install() {
	einstall DESTDIR=${D} install
}
