# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/tilda/tilda-0.02.ebuild,v 1.1 2005/01/08 01:19:05 stuart Exp $

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
S=${WORKDIR}/${P}

src_compile() {
	econf || die "Configure failed"
	emake || die "Make failed"
}

src_install() {
	einstall DESTDIR=${D} install
}
