# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vamps/vamps-0.97.ebuild,v 1.1 2005/03/28 03:41:46 luckyduck Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Very fast requantisizing tool for backup DVDs"
HOMEPAGE="http://sourceforge.net/projects/vamps/"
SRC_URI="mirror://sourceforge/vamps/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="dev-perl/GD
	>=media-libs/libdvdread-0.9.4
	>=media-video/dvdauthor-0.6.10"

src_unpack() {
	unpack ${A} ; cd ${S}
	use amd64 && epatch ${FILESDIR}/${P}-amd64.patch
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}"|| die "emake failed"
}

src_install() {
	dobin vamps play_cell
	dodoc COPYING INSTALL
}
