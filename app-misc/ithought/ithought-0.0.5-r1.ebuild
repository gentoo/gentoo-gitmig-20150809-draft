# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ithought/ithought-0.0.5-r1.ebuild,v 1.20 2005/06/05 11:50:37 hansmi Exp $

#emerge doesn't yet support things like a5

MY_P=${P/0.0./a}
S=${WORKDIR}/${MY_P}
DESCRIPTION="An internet-aware personal thought manager"
HOMEPAGE="http://ithought.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*
	dev-libs/libxml2"

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
