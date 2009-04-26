# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libchipcard/libchipcard-4.2.7.ebuild,v 1.1 2009/04/26 21:12:46 hanno Exp $

EAPI="2"

DESCRIPTION="Libchipcard is a library for easy access to chip cards via chip card readers (terminals)."
HOMEPAGE="http://www.libchipcard.de"
SRC_URI="http://www2.aquamaniac.de/sites/download/download.php?package=02&release=13&file=01&dummy=${P}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"

IUSE="debug doc ssl usb"

DEPEND=">=sys-libs/gwenhywfar-3.8.0
	ssl? ( >=dev-libs/openssl-0.9.6b )
	usb? ( dev-libs/libusb )
	sys-apps/hal"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}"

src_compile() {
	econf \
	`use_enable ssl` \
	`use_enable debug` \
	`use_enable usb libusb` \
	--localstatedir=/var \
	--enable-pcsc || die

	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die

	keepdir /var/log/chipcard \
		/var/lib/chipcardd/newcerts \
		/usr/lib/chipcardd/server/lowlevel

	doinitd "${FILESDIR}/chipcardd4" || die

	dodoc AUTHORS ChangeLog README doc/CERTIFICATES doc/CONFIG doc/IPCCOMMANDS || die
	if use doc ; then
		docinto tutorials
		dodoc tutorials/*.{c,h,xml} tutorials/README || die
	fi

	find "${D}" -name '*.la' -delete
}
