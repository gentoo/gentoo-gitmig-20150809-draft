# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/foo2zjs/foo2zjs-20041030.ebuild,v 1.1 2004/11/20 18:28:15 genstef Exp $

inherit eutils flag-o-matic

DESCRIPTION="Support for printing to ZjStream-based printers"
HOMEPAGE="http://foo2zjs.rkkda.com/"
SRC_URI="mirror://gentoo/${P}.tar.gz
		ftp://ftp.minolta-qms.com/pub/crc/out_going/win/m23dlicc.exe
		ftp://ftp.minolta-qms.com/pub/crc/out_going/win2000/m22dlicc.exe
		ftp://ftp.minolta-qms.com/pub/crc/out_going/windows/cpplxp.exe
		ftp://192.151.53.86/pub/softlib/software2/COL2222/lj-10067-2/lj1005hostbased-en.exe
		ftp://ftp.hp.com/pub/softlib/software1/lj1488/lj-1145-2/lj1488en.exe"
RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"
IUSE="cups foomaticdb usb"
DEPEND="cups? ( net-print/cups )
	foomaticdb? ( net-print/foomatic )
	usb? ( sys-apps/hotplug )"
KEYWORDS="~x86 ~amd64"
S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${P}.tar.gz

	epatch ${FILESDIR}/${PN}-Makefile.patch
	epatch ${FILESDIR}/hp-printer-udev.patch

	# link getweb files in ${S} to get unpacked
	for i in ${A}
	do
		ln -s ${DISTDIR}/${i} ${S}
	done

	cd ${S}
}

src_compile() {
	emake getweb || die "Failed building getweb script"

	# remove wget as we got the firmware with portage
	sed -si "s/.*wget.*//" getweb
	# unpack files
	./getweb all

	emake || die "emake failed"
}

src_install() {
	use foomaticdb && dodir /usr/share/foomatic/db/source

	use cups && dodir /usr/share/cups/model

	make DESTDIR=${D} install \
		|| die "make install failed"

	use usb && make DESTDIR=${D} install-hotplug \
		|| die "make install-hotplug failed"
}
