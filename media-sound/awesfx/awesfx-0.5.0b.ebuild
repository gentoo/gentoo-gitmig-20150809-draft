# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/awesfx/awesfx-0.5.0b.ebuild,v 1.2 2004/04/08 07:27:22 eradicator Exp $

inherit eutils

DESCRIPTION="AWE Utilities - sfxload"
HOMEPAGE="http://www.alsa-project.org/~iwai/awedrv.html#Utils"
SRC_URI=http://www.alsa-project.org/~iwai/${P}.tar.gz
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="alsa"
DEPEND="virtual/glibc
	alsa? ( >=media-libs/alsa-lib-1.0.0 )"

src_compile() {
	if ! use alsa
	then
		einfo "Removing ALSA support!"
		epatch ${FILESDIR}/${P}-configure-noalsa.patch
	fi
	econf --with-sfpath=/usr/share/sfbank || die
	use alsa || epatch ${FILESDIR}/${P}-makefile-noalsa.patch
	#only asfxload seems to need libasound
	use alsa && sed -i -e 's/'^LIBS.*-lasound.*$'/LIBS = -lm -ldl -lpthread/' Makefile
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	# einstall || die
	dodoc AUTHORS ChangeLog INSTALL README SBKtoSF2.txt
}

pkg_postinst() {
	einfo "Please copy your SoundFont files from the original CD-ROM"
	einfo "shipped with your soundcard to"
	einfo "/usr/share/sfbank"
}

