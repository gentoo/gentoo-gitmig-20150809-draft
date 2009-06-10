# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/awesfx/awesfx-0.5.1c.ebuild,v 1.5 2009/06/10 14:48:32 armin76 Exp $

EAPI=2
inherit eutils

DESCRIPTION="AWE32 Sound Driver Utility Programs"
HOMEPAGE="http://ftp.suse.com/pub/people/tiwai/awesfx"
SRC_URI="http://ftp.suse.com/pub/people/tiwai/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE=""

RDEPEND="media-libs/alsa-lib"
DEPEND="${RDEPEND}"

BANK_LOC="/usr/share/sounds/sf2"

src_prepare() {
	epatch "${FILESDIR}"/${P}-getline.patch
}

src_configure() {
	econf \
		--with-sfpath=${BANK_LOC}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README SBKtoSF2.txt samples/README-bank
	rm -f "${D}"/usr/share/sounds/sf2/README-bank
}

pkg_postinst() {
	elog "Copy your SoundFont files from the original CDROM"
	elog "shipped with your soundcard to ${BANK_LOC}."
}
