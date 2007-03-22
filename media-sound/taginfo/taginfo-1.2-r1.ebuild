# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/taginfo/taginfo-1.2-r1.ebuild,v 1.3 2007/03/22 16:46:27 welp Exp $

inherit toolchain-funcs

DESCRIPTION="a simple ID3 tag reader for use in shell scripts"
HOMEPAGE="http://freshmeat.net/projects/taginfo"
SRC_URI="http://grecni.com/software/taginfo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="media-libs/taglib"
DEPEND="${RDEPEND}"

src_compile() {
	emake CC=$(tc-getCXX) || die "emake failed."
}

src_install() {
	dobin taginfo
	dodoc contrib/mp3-resample.sh README ChangeLog
}
