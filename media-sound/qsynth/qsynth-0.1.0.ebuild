# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qsynth/qsynth-0.1.0.ebuild,v 1.1 2004/01/15 01:57:17 wmertens Exp $ 

IUSE=""

DESCRIPTION="A Qt application to control FluidSynth"
HOMEPAGE="http://qsynth.sf.net/"
SRC_URI="mirror://sourceforge/qsynth/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc
	>=x11-libs/qt-3.1.1
	media-sound/fluidsynth"

src_install () {
	einstall || die "make install failed"
}
