# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/chipcard-server/chipcard-server-1.9.7_beta.ebuild,v 1.1 2005/01/05 12:08:01 hanno Exp $

MY_P="chipcard2_server-${PV/_/}"
DESCRIPTION="2nd generation of the chipcard-reader-utility"
HOMEPAGE="http://www.libchipcard.de"
SRC_URI="mirror://sourceforge/libchipcard/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE="debug ssl usb"

DEPEND=">=sys-libs/gwenhywfar-1.4
	ssl? ( >=dev-libs/openssl-0.9.6b )
	usb? ( dev-libs/libusb )"


S=${WORKDIR}/${MY_P}

src_compile() {

	# Fix location of pid file
	sed -i -e \
	's:\$(localstatedir)/run/chipcard2:/var/run:g' configure

	econf \
	`use_enable ssl` \
	`use_enable debug` \
	`use_enable usb libusb` \
	--enable-pcsc || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	doinitd ${FILESDIR}/chipcardd2
	dodoc INSTALL COPYING AUTHORS ChangeLog README
	insinto /etc/chipcard2-server
	doins ${S}/doc/chipcardd2.conf.example
	doins ${S}/doc/chipcardd2.conf.minimal
	cp ${D}/etc/chipcard2-server/chipcardd2.conf.minimal \
		${D}/etc/chipcard2-server/chipcardd2.conf
}
