# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/phasex/phasex-0.11.1.ebuild,v 1.1 2007/10/16 16:02:35 eldad Exp $

DESCRIPTION="Software synthesizer (Phase Harmonic Advanced Synthesis EXperiment)"
HOMEPAGE="http://sysex.net/phasex/"
SRC_URI="http://sysex.net/phasex/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="media-sound/jack-audio-connection-kit"

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS README TODO doc/ROADMAP
}

