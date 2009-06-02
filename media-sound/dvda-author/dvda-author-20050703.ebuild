# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/dvda-author/dvda-author-20050703.ebuild,v 1.2 2009/06/02 12:15:58 flameeyes Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Author a DVD-Audio DVD"
HOMEPAGE="http://dvd-audio.sourceforge.net/"
SRC_URI="mirror://sourceforge/dvd-audio/${P}-Linux.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-libs/flac-1.1.3"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${P}-flac113.diff"
	epatch "${FILESDIR}/${P}-asneeded.patch"
}

src_compile() {
	emake -C src CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dobin src/dvda-author || die "install failed"
	dodoc CHANGES README sort.txt
}
