# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/aseqview/aseqview-0.1.4.ebuild,v 1.6 2004/07/14 20:46:30 agriffis Exp $

IUSE=""

DESCRIPTION="ALSA sequencer event viewer/filter."
HOMEPAGE="http://www.alsa-project.org/~iwai/alsa.html"
LICENSE="GPL-2"

DEPEND=">=media-libs/alsa-lib-0.5.0
	x11-libs/gtk+"

SLOT="0"
KEYWORDS="x86"

SRC_URI="http://www.alsa-project.org/~iwai/${P}.tar.gz"

src_compile() {
	econf || die "./configure failed"
	make clean
	make || die "Make Failed"
}

src_install() {
	einstall || die "Installation Failed"
	dodoc AUTHORS COPYING ChangeLog NEWS README
}
