# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/taginfo/taginfo-1.2.ebuild,v 1.2 2006/07/02 18:31:53 jhuebel Exp $

DESCRIPTION="a simple ID3 tag reader for use in shell scripts"
HOMEPAGE="http://freshmeat.net/projects/taginfo/"
SRC_URI="http://grecni.com/software/taginfo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""
RDEPEND="media-libs/taglib"
DEPEND="${RDEPEND}"

src_compile() {
	cd ${S}
	emake || die "emake failed"
}

src_install() {
	cd ${S}
	exeinto /usr/local/bin
	doexe taginfo

	dodoc contrib/mp3-resample.sh README ChangeLog COPYING
}
