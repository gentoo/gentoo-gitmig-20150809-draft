# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qsynth/qsynth-0.2.6.ebuild,v 1.1 2007/06/20 14:39:34 flameeyes Exp $

inherit qt3 eutils

DESCRIPTION="A Qt application to control FluidSynth"
HOMEPAGE="http://qsynth.sf.net/"
SRC_URI="mirror://sourceforge/qsynth/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
IUSE="debug"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND="$(qt_min_version 3)
	media-sound/fluidsynth"

src_compile() {
	econf \
		$(use_enable debug) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README TODO

	make_desktop_entry qsynth Qsynth qsynth
}
