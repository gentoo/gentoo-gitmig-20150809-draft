# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/bitscope/bitscope-1.1.ebuild,v 1.6 2004/10/19 07:27:23 eradicator Exp $

IUSE=""

DESCRIPTION="A diagnosis tool for JACK audio software"
HOMEPAGE="http://www.ecs.soton.ac.uk/~njl98r/code/ladspa/"
SRC_URI="http://www.ecs.soton.ac.uk/~njl98r/code/ladspa/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 ~ppc sparc"

DEPEND="media-sound/jack-audio-connection-kit
	>=x11-libs/gtk+-2"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc INSTALL README
	dohtml doc/*png doc/index.html
}
