# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pmidi/pmidi-1.6.0.ebuild,v 1.6 2004/11/06 14:30:27 pylon Exp $

IUSE=""

DESCRIPTION="Command line midi player for ALSA."
HOMEPAGE="http://www.parabola.demon.co.uk/alsa/pmidi.html"

SRC_URI="mirror://sourceforge/pmidi/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"

DEPEND=">=media-libs/alsa-lib-0.9.0_rc6"
KEYWORDS="x86 amd64 ppc"

src_install() {
	make DESTDIR="${D}" install || die "Installation Failed"
	dodoc AUTHORS COPYING ChangeLog NEWS README
}
