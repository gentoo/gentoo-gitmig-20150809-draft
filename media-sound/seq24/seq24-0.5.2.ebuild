# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/seq24/seq24-0.5.2.ebuild,v 1.3 2005/01/06 00:59:21 fvdpol Exp $

IUSE=""

DESCRIPTION="Seq24 is a loop based MIDI sequencer with focus on live performances."
HOMEPAGE="http://www.filter24.org/seq24/"
SRC_URI="http://www.filter24.org/seq24/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc"

DEPEND=">=media-libs/alsa-lib-0.9.0
	=dev-cpp/gtkmm-1.2*"

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog README RTC SEQ24
}
