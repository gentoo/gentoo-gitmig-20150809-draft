# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/shorten/shorten-3.6.0.ebuild,v 1.2 2004/10/19 06:23:05 eradicator Exp $

IUSE=""

DESCRIPTION="fast, low complexity waveform coder (i.e. audio compressor)"
HOMEPAGE="http://etree.org/shnutils/shorten/"
SRC_URI="http://etree.org/shnutils/shorten/source/${P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="amd64 ~ppc sparc x86"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS LICENSE ChangeLog NEWS README
}
