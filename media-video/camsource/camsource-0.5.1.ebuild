# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/camsource/camsource-0.5.1.ebuild,v 1.13 2004/07/14 21:31:28 agriffis Exp $

DESCRIPTION="Camsource grabs images from a video4linux device and makes them available
			to various plugins for processing or handling. Camsource can also be used
			as a streaming webcam server."

HOMEPAGE="http://camsource.sourceforge.net/"
SRC_URI="http://umn.dl.sourceforge.net/sourceforge/camsource/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ~ppc ~alpha"
IUSE=""

DEPEND=">=dev-libs/libxml2-2.4.22
		>=media-libs/jpeg-6b"

RDEPEND=""

src_compile() {

	econf || die
	emake || die
}

src_install() {

	einstall
}

pkg_postinst() {

	einfo ""
	einfo "Please edit the configuration file: "
	einfo "/etc/camsource.conf.example"
	einfo "to your liking."
	einfo ""

}
