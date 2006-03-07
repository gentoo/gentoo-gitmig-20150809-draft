# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gtick/gtick-0.2.4.ebuild,v 1.8 2006/03/07 14:51:38 flameeyes Exp $

IUSE=""

DESCRIPTION="a metronome application supporting different meters and speeds ranging"
HOMEPAGE="http://www.antcom.de/gtick/"
SRC_URI="http://savannah.nongnu.org/download/gtick/default.pkg/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=x11-libs/gtk+-2.0"

src_install() {
	einstall || die
	dodoc AUTHORS REAME NEWS
}
