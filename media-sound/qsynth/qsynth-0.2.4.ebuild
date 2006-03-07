# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qsynth/qsynth-0.2.4.ebuild,v 1.2 2006/03/07 15:30:15 flameeyes Exp $

DESCRIPTION="A Qt application to control FluidSynth"
HOMEPAGE="http://qsynth.sf.net/"
SRC_URI="mirror://sourceforge/qsynth/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND="=x11-libs/qt-3*
	media-sound/fluidsynth"

src_compile() {
	addwrite ${QTDIR}/etc/settings
	econf || die
	emake || die
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README TODO
}
