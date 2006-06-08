# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/joymouse/joymouse-0.5.ebuild,v 1.2 2006/06/08 09:46:54 vapier Exp $

DESCRIPTION="An application that translates joystick events to mouse events"
HOMEPAGE="http://sourceforge.net/projects/joymouse-linux"
SRC_URI="mirror://sourceforge/joymouse-linux/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~mips ~ppc ~x86"
IUSE=""

DEPEND="x11-proto/xextproto"
RDEPEND="x11-libs/libX11 x11-libs/libXtst"

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS README
}
