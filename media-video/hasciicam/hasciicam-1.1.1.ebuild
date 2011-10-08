# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/hasciicam/hasciicam-1.1.1.ebuild,v 1.3 2011/10/08 16:18:26 phajdan.jr Exp $

EAPI=4

DESCRIPTION="a webcam software displaying ascii art using aalib."
HOMEPAGE="http://ascii.dyne.org"
SRC_URI="ftp://ftp.dyne.org/${PN}/releases/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="media-libs/aalib"
DEPEND="${RDEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
}
