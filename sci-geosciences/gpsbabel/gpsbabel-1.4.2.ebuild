# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/gpsbabel/gpsbabel-1.4.2.ebuild,v 1.1 2010/11/08 00:59:36 fauli Exp $

EAPI=2

DESCRIPTION="GPS waypoints, tracks and routes converter"
HOMEPAGE="http://www.gpsbabel.org/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="usb"

RDEPEND="dev-libs/expat
	usb? ( dev-libs/libusb )"
DEPEND="${RDEPEND}"

src_configure() {
	econf $(use_with usb libusb) \
		--with-zlib=system
}

src_compile() {
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README* || die
}
