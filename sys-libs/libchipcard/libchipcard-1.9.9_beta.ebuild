# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libchipcard/libchipcard-1.9.9_beta.ebuild,v 1.4 2005/02/14 19:06:06 blubb Exp $

inherit eutils

MY_P="${PN}2-${PV/_/}"
DESCRIPTION="Libchipcard is a library for easy access to chip cards via chip card readers (terminals)."
HOMEPAGE="http://www.libchipcard.de"
SRC_URI="mirror://sourceforge/libchipcard/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~x86 ~sparc ~alpha ~ppc ~amd64"

IUSE="debug ssl usb"

DEPEND=">=sys-libs/gwenhywfar-1.7.2
	ssl? ( >=dev-libs/openssl-0.9.6b )
	usb? ( dev-libs/libusb )
	>=sys-fs/sysfsutils-1.2.0 "


S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/libchipcard_compile_fix.gz
}

src_compile() {

	# Fix location of pid file
	sed -i -e \
	's:\${localstatedir}/run/chipcard2:/var/run:g' configure

	econf \
	`use_enable ssl` \
	`use_enable debug` \
	`use_enable usb libusb` \
	--enable-pcsc || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	# ctapi.h conflicts with towitoko-package
	rm ${D}/usr/include/ctapi.h

	doinitd ${FILESDIR}/chipcardd2
	dodoc INSTALL COPYING AUTHORS ChangeLog README
	cp ${D}/etc/chipcard2-client/chipcardc2.conf.example \
		${D}/etc/chipcard2-client/chipcardc2.conf
	cp ${D}/etc/chipcard2-server/chipcardd2.conf.minimal \
		${D}/etc/chipcard2-server/chipcardd2.conf
}
