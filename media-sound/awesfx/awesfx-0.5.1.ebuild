# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/awesfx/awesfx-0.5.1.ebuild,v 1.1 2007/07/29 12:30:19 drac Exp $

inherit eutils portability

DESCRIPTION="AWE Utilities - sfxload"
HOMEPAGE="http://www.alsa-project.org/~iwai/awedrv.html#Utils"
SRC_URI="http://ftp.suse.com/pub/people/tiwai/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="alsa"

DEPEND="alsa? ( >=media-libs/alsa-lib-1 )"

BANK_LOC="/usr/share/sounds/sf2"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-include.patch
}

src_compile() {
	if ! use alsa; then
		einfo "Removing ALSA support!"
		epatch "${FILESDIR}"/${P}-configure-noalsa.patch
		econf --with-sfpath=${BANK_LOC} || die
		epatch "${FILESDIR}"/${P}-makefile-noalsa.patch
		sed -i -e 's/'^LIBS.*-lasound.*$'/LIBS = -lm $(dlopen_lib) -lpthread/' Makefile
	else
		econf --with-sfpath=${BANK_LOC} || die
	fi

	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README SBKtoSF2.txt
	dodoc "${D}"/usr/share/sounds/sf2/README-bank
	rm "${D}"/usr/share/sounds/sf2/README-bank
}

pkg_postinst() {
	elog "Please copy your SoundFont files from the original CD-ROM"
	elog "shipped with your soundcard to ${BANK_LOC}"
}
