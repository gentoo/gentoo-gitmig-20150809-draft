# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vamps/vamps-0.95.ebuild,v 1.4 2004/10/26 14:33:47 chriswhite Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Very fast requantisizing tool for backup DVDs"
HOMEPAGE="http://www.heise.de/ct/ftp/04/01/094/"
SRC_URI="ftp://ftp.heise.de/pub/ct/listings/0401-094.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="dev-perl/GD
	dev-perl/Getopt-Long
	dev-perl/Config-IniFiles
	>=media-libs/libdvdread-0.9.4
	>=media-video/dvdauthor-0.6.10"

src_unpack() {
	unpack ${A} ; cd ${S}
	use amd64 && epatch ${FILESDIR}/${P}-amd64.patch
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="$CFLAGS" || die "emake failed"
	mv -fv lsdvd lsdvd-vamps # rename to avoid conflict with media-video/lsdvd
}

src_install() {
	dobin vamps lsdvd-vamps vamps-play_title dvdgm.pl
	dodoc COPYING INSTALL README
	insinto /usr/share/vamps
	doins ct-dvd.xml dvdgm.cfg palette.yuv penguin.jpg silence.mp2
}
