# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/zphoto/zphoto-0.7.ebuild,v 1.1 2004/03/27 11:38:36 usata Exp $

inherit eutils

IUSE=""

DESCRIPTION="A zooming photo album generator in Flash"
SRC_URI="http://namazu.org/~satoru/zphoto/${P}.tar.gz"
HOMEPAGE="http://namazu.org/~satoru/zphoto/"

SLOT="0"
KEYWORDS="~x86"
LICENSE="LGPL-2.1"

DEPEND=">=media-libs/ming-0.2a
	>=media-libs/imlib2-1.0.6-r1
	>=media-video/avifile-0.7.34
	app-arch/zip
	>=dev-libs/popt-1.6.3"

src_unpack() {

	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-avifile-gentoo.diff
}

src_install() {

	einstall || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
}
