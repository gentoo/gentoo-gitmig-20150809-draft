# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/awesfx/awesfx-0.5.0c.ebuild,v 1.1 2004/07/21 19:55:23 eradicator Exp $

IUSE="alsa"

inherit eutils

DESCRIPTION="AWE Utilities - sfxload"
HOMEPAGE="http://www.alsa-project.org/~iwai/awedrv.html#Utils"
SRC_URI=http://www.alsa-project.org/~iwai/${P}.tar.gz
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
DEPEND="virtual/libc
	alsa? ( >=media-libs/alsa-lib-1.0.0 )"

src_compile() {
	if ! use alsa; then
		einfo "Removing ALSA support!"
		epatch ${FILESDIR}/${PN}-0.5.0b-configure-noalsa.patch
		econf --with-sfpath=/usr/share/sfbank || die
		epatch ${FILESDIR}/${PN}-0.5.0b-makefile-noalsa.patch
		sed -i -e 's/'^LIBS.*-lasound.*$'/LIBS = -lm -ldl -lpthread/' Makefile
	else
		econf --with-sfpath=/usr/share/sfbank || die
	fi

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL README SBKtoSF2.txt
}

pkg_postinst() {
	einfo "Please copy your SoundFont files from the original CD-ROM"
	einfo "shipped with your soundcard to"
	einfo "/usr/share/sfbank"
}

