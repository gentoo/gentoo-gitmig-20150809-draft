# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/vorbisgain/vorbisgain-0.37.ebuild,v 1.1 2007/11/23 13:02:22 drac Exp $

DESCRIPTION="Calculator of perceived sound level for Ogg Vorbis files"
HOMEPAGE="http://sjeng.org/vorbisgain.html"
SRC_URI="http://sjeng.org/ftp/vorbis/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=media-libs/libvorbis-1
	media-libs/libogg"
DEPEND="${RDEPEND}"

src_compile() {
	econf --enable-recursive
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc NEWS README *.txt
}
