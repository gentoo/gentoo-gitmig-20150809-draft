# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sfc/sfc-0.015.ebuild,v 1.5 2004/07/20 06:18:41 eradicator Exp $

DESCRIPTION="SoundFontCombi is a opensource software pseudo synthesizer."
HOMEPAGE="http://personal.telefonica.terra.es/web/soudfontcombi/"
SRC_URI="http://personal.telefonica.terra.es/web/soudfontcombi/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"

IUSE=""

DEPEND=">=x11-libs/fltk-1.1.2
	media-libs/alsa-lib"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README
}
