# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libchipcard/libchipcard-3.0.4.ebuild,v 1.11 2009/05/16 09:23:37 robbat2 Exp $

MY_P="${PN}3-${PV}"
DESCRIPTION="Libchipcard is a library for easy access to chip cards via chip card readers (terminals)."
HOMEPAGE="http://www.libchipcard.de"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="2"
KEYWORDS="amd64 hppa ppc ~ppc64 sparc x86"

IUSE="debug doc ssl usb"

DEPEND=">=sys-libs/gwenhywfar-2.6.1
	ssl? ( >=dev-libs/openssl-0.9.6b )
	usb? ( =virtual/libusb-0* )
	>=sys-fs/sysfsutils-1.2.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

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

	keepdir /var/log/chipcard3 \
		/var/lib/chipcard3/newcerts \
		/usr/lib/chipcard3/server/lowlevel

	doinitd "${FILESDIR}/chipcardd3" || die

	dodoc AUTHORS ChangeLog README doc/CERTIFICATES doc/CONFIG doc/IPCCOMMANDS || die
	if use doc ; then
		docinto tutorials
		dodoc tutorials/*.{c,h,xml} tutorials/README || die
	fi
}
