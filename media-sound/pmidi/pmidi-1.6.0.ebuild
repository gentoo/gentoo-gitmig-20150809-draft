# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pmidi/pmidi-1.6.0.ebuild,v 1.7 2004/11/23 10:14:52 eradicator Exp $

IUSE=""

DESCRIPTION="Command line midi player for ALSA."
HOMEPAGE="http://www.parabola.demon.co.uk/alsa/pmidi.html"
SRC_URI="mirror://sourceforge/pmidi/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"

DEPEND=">=media-libs/alsa-lib-0.9.0_rc6"

src_install() {
	make DESTDIR="${D}" install || die "Installation Failed"
	dodoc AUTHORS ChangeLog NEWS README
}
