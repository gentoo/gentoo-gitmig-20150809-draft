# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/foo2zjs/foo2zjs-20060501.ebuild,v 1.1 2006/05/03 11:36:52 genstef Exp $

inherit eutils flag-o-matic

DESCRIPTION="Support for printing to ZjStream-based printers"
HOMEPAGE="http://foo2zjs.rkkda.com/"
SRC_URI="ftp://ftp.minolta-qms.com/pub/crc/out_going/win/m23dlicc.exe
		ftp://ftp.minolta-qms.com/pub/crc/out_going/win2000/m22dlicc.exe
		ftp://ftp.minolta-qms.com/pub/crc/out_going/windows/cpplxp.exe
		http://dev.gentoo.org/~genstef/files/dist/${P}.tar.gz"
RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"
IUSE="cups foomaticdb usb"
DEPEND="app-arch/unzip
	dev-lang/perl"
RDEPEND="cups? ( net-print/cups )
	foomaticdb? ( net-print/foomatic )
	usb? ( || ( sys-fs/udev sys-apps/hotplug ) )"
KEYWORDS="~x86 ~amd64"
S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${P}.tar.gz

	# link getweb files in ${S} to get unpacked
	for i in m23dlicc.exe m22dlicc.exe cpplxp.exe
	do
		ln -s ${DISTDIR}/${i} ${S}
	done

	cd ${S}
	epatch ${FILESDIR}/foo2zjs-Makefile-20060501.diff
	epatch ${FILESDIR}/foo2zjs-udevfwld-20060501.diff
}

src_compile() {
	emake getweb || die "Failed building getweb script"

	# remove wget as we got the firmware with portage
	sed -si "s/.*wget.*//" getweb
	sed -si "s/error \"Couldn't dow.*//" getweb
	# unpack files
	./getweb all

	emake || die "emake failed"
}

src_install() {
	use foomaticdb && dodir /usr/share/foomatic/db/source

	use cups && dodir /usr/share/cups/model

	make DESTDIR=${D} install \
		|| die "make install failed"

	if use usb; then
		if [ -x ${ROOT}/sbin/udevsend ]; then
			make DESTDIR=${D} install-udev \
				|| die "make install-udev failed"
		else
			make DESTDIR=${D} install-hotplug \
				|| die "make install-hotplug failed"
		fi
	fi
}

pkg_postinst() {
	rm ${ROOT}/etc/udev/rules.d/58-foo2zjs.rules
}
