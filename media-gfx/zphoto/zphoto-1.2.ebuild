# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/zphoto/zphoto-1.2.ebuild,v 1.2 2004/11/04 11:54:28 usata Exp $

inherit eutils

IUSE=""

DESCRIPTION="A zooming photo album generator in Flash"
SRC_URI="http://namazu.org/~satoru/zphoto/${P}.tar.gz"
HOMEPAGE="http://namazu.org/~satoru/zphoto/"

SLOT="0"
KEYWORDS="x86"
LICENSE="LGPL-2.1"

DEPEND=">=media-libs/ming-0.2a
	|| ( >=media-libs/imlib2-1.1.0 >=media-gfx/imagemagick-5.5.7 )
	>=media-video/avifile-0.7.34
	app-arch/zip
	>=dev-libs/popt-1.6.3"

#src_unpack() {
#
#	unpack ${A}
#	cd ${S}
#	epatch ${FILESDIR}/zphoto-0.9-avifile-gentoo.diff
#}

src_compile() {

	# GUI version won't build -- please mail me if you find
	# a way to fix it. <usata@gentoo.org> 7 Jul 2004
	econf --disable-wx || die
	emake || die
}

src_install() {

	einstall || die

	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
