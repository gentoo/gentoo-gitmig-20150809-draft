# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/awesfx/awesfx-0.5.0d.ebuild,v 1.1 2004/12/08 12:05:53 eradicator Exp $

IUSE="alsa"

inherit eutils

DESCRIPTION="AWE Utilities - sfxload"
HOMEPAGE="http://www.alsa-project.org/~iwai/awedrv.html#Utils"
SRC_URI=http://www.alsa-project.org/~iwai/${P}.tar.gz

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND="virtual/libc
	alsa? ( >=media-libs/alsa-lib-1.0.0 )"

BANK_LOC="/usr/share/sounds/sf2"

src_compile() {
	if ! use alsa; then
		einfo "Removing ALSA support!"
		epatch ${FILESDIR}/${PN}-0.5.0b-configure-noalsa.patch
		econf --with-sfpath=${BANK_LOC} || die
		epatch ${FILESDIR}/${PN}-0.5.0b-makefile-noalsa.patch
		sed -i -e 's/'^LIBS.*-lasound.*$'/LIBS = -lm -ldl -lpthread/' Makefile
	else
		econf --with-sfpath=${BANK_LOC} || die
	fi

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog README SBKtoSF2.txt
	dodoc ${D}/usr/share/sounds/sf2/README-bank
	rm ${D}/usr/share/sounds/sf2/README-bank
}

pkg_postinst() {
	einfo "Please copy your SoundFont files from the original CD-ROM"
	einfo "shipped with your soundcard to ${BANK_LOC}"
}
