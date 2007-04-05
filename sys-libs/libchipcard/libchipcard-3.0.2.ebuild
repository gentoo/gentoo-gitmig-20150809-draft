# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libchipcard/libchipcard-3.0.2.ebuild,v 1.3 2007/04/05 16:43:17 hanno Exp $

MY_P="${PN}3-${PV}"
DESCRIPTION="Libchipcard is a library for easy access to chip cards via chip card readers (terminals)."
HOMEPAGE="http://www.libchipcard.de"
SRC_URI="mirror://sourceforge/libchipcard/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"

IUSE="debug doc ssl usb"

DEPEND=">=sys-libs/gwenhywfar-2.5.1
	ssl? ( >=dev-libs/openssl-0.9.6b )
	usb? ( dev-libs/libusb )
	>=sys-fs/sysfsutils-1.2.0"


S=${WORKDIR}/${MY_P}

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
	make DESTDIR=${D} install || die

	keepdir /var/log/chipcard3 \
		/var/lib/chipcard3/newcerts \
		/usr/lib/chipcard3/server/lowlevel

	doinitd ${FILESDIR}/chipcardd3

	dodoc AUTHORS ChangeLog README doc/CERTIFICATES doc/CONFIG doc/IPCCOMMANDS
	if use doc ; then
		docinto tutorials
		dodoc tutorials/*.{c,h,xml} tutorials/README
	fi
}
