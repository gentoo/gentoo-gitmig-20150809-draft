# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qsynth/qsynth-0.2.1.ebuild,v 1.5 2004/09/03 17:17:43 eradicator Exp $

DESCRIPTION="A Qt application to control FluidSynth"
HOMEPAGE="http://qsynth.sf.net/"
SRC_URI="mirror://sourceforge/qsynth/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
IUSE=""
KEYWORDS="x86 amd64 ~ppc"

DEPEND="virtual/libc
	>=x11-libs/qt-3.1.1
	media-sound/fluidsynth"

src_compile() {
	addwrite ${QTDIR}/etc/settings
	econf || die
	emake || die
}

src_install () {
	einstall || die "make install failed"
	dodoc AUTHORS COPYING ChangeLog README TODO
}
