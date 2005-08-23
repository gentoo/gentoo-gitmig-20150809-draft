# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/vorbisgain/vorbisgain-0.36.ebuild,v 1.2 2005/08/23 22:14:56 chainsaw Exp $

DESCRIPTION="Vorbisgain calculates a perceived sound level of an Ogg Vorbis file using the ReplayGain algorithm and stores it in the file header"
HOMEPAGE="http://sjeng.org/vorbisgain.html"
SRC_URI="http://sjeng.org/ftp/vorbis/${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~sparc ~ppc ~ppc64"
IUSE=""

RDEPEND=">=media-libs/libvorbis-1.0_beta4
	media-libs/libogg"
DEPEND="${RDEPEND}
	app-arch/unzip"

src_compile() {
	chmod +x configure
	econf --enable-recursive || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
}
