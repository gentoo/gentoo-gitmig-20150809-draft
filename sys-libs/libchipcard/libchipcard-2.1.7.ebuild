# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libchipcard/libchipcard-2.1.7.ebuild,v 1.1 2006/07/21 23:54:39 hanno Exp $

MY_P="${PN}2-${PV}"
DESCRIPTION="Libchipcard is a library for easy access to chip cards via chip card readers (terminals)."
HOMEPAGE="http://www.libchipcard.de"
SRC_URI="mirror://sourceforge/libchipcard/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"

IUSE="debug doc ssl usb"

DEPEND=">=sys-libs/gwenhywfar-2.3.1
	ssl? ( >=dev-libs/openssl-0.9.6b )
	usb? ( dev-libs/libusb )
	>=sys-fs/sysfsutils-1.2.0"


S=${WORKDIR}/${MY_P}

src_compile() {
	econf \
	`use_enable ssl` \
	`use_enable debug` \
	`use_enable usb libusb` \
	--datadir=/usr/lib/chipcard2-server \
	--localstatedir=/var \
	--enable-pcsc || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	keepdir /var/log/chipcard2 \
		/var/lib/chipcard2/newcerts \
		/usr/lib/chipcard2-server/lowlevel

	dodoc AUTHORS ChangeLog README doc/CERTIFICATES doc/CONFIG doc/IPCCOMMANDS
	if use doc ; then
		docinto tutorials
		dodoc tutorials/*.{c,h,xml} tutorials/README
	fi
}
