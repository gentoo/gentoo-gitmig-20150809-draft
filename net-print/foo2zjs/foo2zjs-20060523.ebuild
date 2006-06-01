# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/foo2zjs/foo2zjs-20060523.ebuild,v 1.1 2006/06/01 16:45:38 genstef Exp $

inherit eutils

DESCRIPTION="Support for printing to ZjStream-based printers"
HOMEPAGE="http://foo2zjs.rkkda.com/"
SRC_URI="ftp://ftp.minolta-qms.com/pub/crc/out_going/win/m23dlicc.exe
		ftp://ftp.minolta-qms.com/pub/crc/out_going/win2000/m22dlicc.exe
		ftp://ftp.minolta-qms.com/pub/crc/out_going/windows/cpplxp.exe
		http://gentooexperimental.org/~genstef/dist/${P}.tar.gz
		http://foo2zjs.rkkda.com/sihp1000.tar.gz
		http://foo2zjs.rkkda.com/sihp1005.tar.gz
		http://foo2zjs.rkkda.com/sihp1018.tar.gz
		http://foo2zjs.rkkda.com/sihp1020.tar.gz
		http://foo2zjs.rkkda.com/km2430.tar.gz
		http://foo2hp.rkkda.com/hpclj2600n.tar.gz"
RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"
IUSE="cups foomaticdb usb"
DEPEND="app-arch/unzip"
RDEPEND="cups? ( net-print/cups )
	foomaticdb? ( net-print/foomatic )
	usb? ( || ( sys-fs/udev sys-apps/hotplug ) )"
KEYWORDS="~x86 ~amd64 ~ppc"
S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${P}.tar.gz

	# link getweb files in ${S} to get unpacked
	for i in ${A}
	do
		ln -s ${DISTDIR}/${i} ${S}
	done

	cd ${S}
	epatch ${FILESDIR}/foo2zjs-Makefile-20060523.diff
	epatch ${FILESDIR}/foo2zjs-udevfwld-20060523.diff
}

src_compile() {
	emake getweb || die "Failed building getweb script"

	# remove wget as we got the firmware with portage
	sed -i -e "s/.*wget.*//" \
		-e "s/error \"Couldn't dow.*//" getweb
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
	rm -f ${ROOT}/etc/udev/rules.d/58-foo2zjs.rules
}
