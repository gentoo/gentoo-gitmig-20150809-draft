# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3info/mp3info-0.8.4-r1.ebuild,v 1.18 2004/11/15 20:08:13 corsair Exp $

inherit eutils

IUSE="gtk"

DESCRIPTION="An MP3 technical info viewer and ID3 1.x tag editor"
SRC_URI="http://ibiblio.org/pub/linux/apps/sound/mp3-utils/${PN}/${P}.tgz"
HOMEPAGE="http://ibiblio.org/mp3info/"

DEPEND="gtk? ( =x11-libs/gtk+-1.2* )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc amd64 ~ppc64"

src_unpack() {
	unpack ${A}

	cd ${S}
	sed -i "s:-O2:${CFLAGS}:" Makefile
	epatch ${FILESDIR}/gcc.patch
}

src_compile() {
	emake mp3info || die
	if use gtk; then
		emake gmp3info || die "gtk mp3info failed"
	fi
}

src_install() {
	dobin mp3info
	use gtk && dobin gmp3info

	dodoc ChangeLog INSTALL LICENSE README
	doman mp3info.1
}
