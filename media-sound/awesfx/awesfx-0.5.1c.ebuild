# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/awesfx/awesfx-0.5.1c.ebuild,v 1.1 2008/01/14 15:16:23 drac Exp $

DESCRIPTION="AWE32 Sound Driver Utility Programs"
HOMEPAGE="http://ftp.suse.com/pub/people/tiwai/awesfx"
SRC_URI="http://ftp.suse.com/pub/people/tiwai/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=media-libs/alsa-lib-1"

BANK_LOC="/usr/share/sounds/sf2"

src_compile() {
	econf --with-sfpath=${BANK_LOC}
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README SBKtoSF2.txt samples/README-bank
	rm "${D}"/usr/share/sounds/sf2/README-bank
}

pkg_postinst() {
	elog "Copy your SoundFont files from the original CDROM"
	elog "shipped with your soundcard to ${BANK_LOC}."
}
