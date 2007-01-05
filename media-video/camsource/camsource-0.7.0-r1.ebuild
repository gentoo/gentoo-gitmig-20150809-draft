# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/camsource/camsource-0.7.0-r1.ebuild,v 1.13 2007/01/05 20:29:09 flameeyes Exp $

inherit eutils

DESCRIPTION="Camsource grabs images from a video4linux webcam device."

HOMEPAGE="http://camsource.sourceforge.net/"
SRC_URI="mirror://sourceforge/camsource/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc sparc x86"
IUSE=""

DEPEND=">=dev-libs/libxml2-2.4.22
		>=media-libs/jpeg-6b"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/gcc34.patch
}

src_compile() {
	econf || die
	emake || die
}

src_install() {

	einstall
	dodoc AUTHORS README NEWS
}

pkg_postinst() {

	elog
	elog "Please edit the configuration file:"
	elog "/etc/camsource.conf.example"
	elog "to your liking."
	elog

}
