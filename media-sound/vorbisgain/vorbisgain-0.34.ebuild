# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/vorbisgain/vorbisgain-0.34.ebuild,v 1.1 2003/09/29 02:41:36 jje Exp $

DESCRIPTION="vorbisgain calculates a percieved sound level of an Ogg Vorbis file using the ReplayGain algorithm and stores it in the file header"
HOMEPAGE="http://users.pandora.be/sjeng/vorbisgain.html"
SRC_URI="http://sjeng.org/ftp/vorbis/${P}.zip"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"

DEPEND=">=media-libs/libvorbis-1.0
	app-arch/unzip"

src_compile() {
	chmod +x configure
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}

