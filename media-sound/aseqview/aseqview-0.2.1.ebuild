# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/aseqview/aseqview-0.2.1.ebuild,v 1.6 2004/11/23 03:16:56 eradicator Exp $

IUSE=""

DESCRIPTION="ALSA sequencer event viewer/filter."
HOMEPAGE="http://www.alsa-project.org/~iwai/alsa.html"
SRC_URI="http://www.alsa-project.org/~iwai/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~sparc x86"

DEPEND=">=media-libs/alsa-lib-0.9.0
	x11-libs/gtk+"

src_compile() {
	econf || die "./configure failed"
	make clean
	make || die "Make Failed"
}

src_install() {
	einstall || die "Installation Failed"
	dodoc AUTHORS COPYING ChangeLog NEWS README
}
