# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gtick/gtick-0.3.0.ebuild,v 1.7 2004/09/14 16:33:42 eradicator Exp $

IUSE=""

DESCRIPTION="a metronome application supporting different meters and speeds ranging"
HOMEPAGE="http://www.antcom.de/gtick/"
SRC_URI="http://www.antcom.de/gtick/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc amd64"

DEPEND=">=x11-libs/gtk+-2.0"

src_install() {
	make DESTDIR=${D} install || die
	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog NEWS README THANKS TODO
}
