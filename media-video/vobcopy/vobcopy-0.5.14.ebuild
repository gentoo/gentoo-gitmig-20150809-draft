# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vobcopy/vobcopy-0.5.14.ebuild,v 1.3 2005/06/27 07:43:13 corsair Exp $

IUSE=""

DESCRIPTION="copies DVD .vob files to harddisk, decrypting them on the way"
HOMEPAGE="http://lpn.rnbhq.org/"
SRC_URI="http://lpn.rnbhq.org/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ppc64 ~sparc ~x86"

DEPEND=">=media-libs/libdvdread-0.9.4"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin vobcopy || die "dobin failed"
	doman vobcopy.1 || die "doman failed"
	dodoc Changelog README Release-Notes TODO alternative_programs.txt \
		|| die "dodoc failed"
}
