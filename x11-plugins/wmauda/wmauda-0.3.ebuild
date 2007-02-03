# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmauda/wmauda-0.3.ebuild,v 1.2 2007/02/03 03:02:15 beandog Exp $

DESCRIPTION="Dockable applet for WindowMaker that controls Audacious."
SRC_URI="http://downloads.alteredeclipse.org/${P}.tar.bz2"
HOMEPAGE="http://software.alteredeclipse.org/"

DEPEND="=x11-libs/gtk+-2*
	media-sound/audacious"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

src_compile() {
	emake || die
}

src_install () {
	make DESTDIR="${D}" PREFIX="/usr" install || die "make install failed"
	dodoc README AUTHORS
}
