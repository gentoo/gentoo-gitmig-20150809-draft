# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vamps/vamps-0.98.ebuild,v 1.2 2005/12/28 12:00:23 zzam Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Very fast requantisizing tool for backup DVDs"
HOMEPAGE="http://sourceforge.net/projects/vamps/"
SRC_URI="mirror://sourceforge/vamps/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=">=media-libs/libdvdread-0.9.4"

RDEPEND="${DEPEND}
		>=media-video/dvdauthor-0.6.10"

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}"|| die "emake failed"
}

src_install() {
	dobin vamps/vamps play_cell/play_cell
}
