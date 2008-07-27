# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kaconnect/kaconnect-1.1.1.ebuild,v 1.12 2008/07/27 21:53:07 carlo Exp $

EAPI=1

inherit qt3 toolchain-funcs eutils

IUSE=""

DESCRIPTION="Part of Kalsatools - QT based frontend to aconnect"
HOMEPAGE="http://www.suse.de/~mana/kalsatools.html"
SRC_URI="ftp://ftp.suse.com/pub/people/mana/kalsatools-current/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"

RDEPEND="media-sound/alsa-utils
	x11-libs/qt:3"

DEPEND="${RDEPEND}
	sys-apps/sed"

src_unpack() {
	unpack ${A} || die

	sed -i -e 's:/usr/lib/qt3:/usr/qt/3:g' \
		's:gcc:${CC} ${CFLAGS} ${LDFLAGS}:g' \
		"${S}/make_kaconnect"

	epatch "${FILESDIR}/${P}-gcc41.patch"
}

src_compile() {
	emake CC="$(tc-getCC)" -f make_kaconnect || die "Make failed."
}

src_install () {
	dobin kaconnect
	dodoc README THANKS LICENSE kalsatools.changes
}
