# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/awesfx/awesfx-0.5.0c.ebuild,v 1.7 2007/01/05 17:23:30 flameeyes Exp $

IUSE="alsa"

inherit eutils portability

DESCRIPTION="AWE Utilities - sfxload"
HOMEPAGE="http://www.alsa-project.org/~iwai/awedrv.html#Utils"
SRC_URI=http://www.alsa-project.org/~iwai/${P}.tar.gz

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"

DEPEND="alsa? ( >=media-libs/alsa-lib-1.0.0 )"

BANK_LOC="/usr/share/sounds/sf2"

src_compile() {
	if ! use alsa; then
		einfo "Removing ALSA support!"
		epatch ${FILESDIR}/${PN}-0.5.0b-configure-noalsa.patch
		econf --with-sfpath=${BANK_LOC} || die
		epatch ${FILESDIR}/${PN}-0.5.0b-makefile-noalsa.patch
		sed -i -e 's/'^LIBS.*-lasound.*$'/LIBS = -lm $(dlopen_lib) -lpthread/' Makefile
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
	elog "Please copy your SoundFont files from the original CD-ROM"
	elog "shipped with your soundcard to ${BANK_LOC}"
}
