# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/capi4k-utils/capi4k-utils-20050322.ebuild,v 1.1 2005/03/29 06:43:28 mrness Exp $

YEAR_PV=${PV:0:4}
MON_PV=${PV:4:2}
DAY_PV=${PV:6:2}
MY_P=${PN}-${YEAR_PV}-${MON_PV}-${DAY_PV}
PPPVERSIONS="2.4.2 2.4.3"  # versions in portage

DESCRIPTION="CAPI4Linux Utils"
HOMEPAGE="ftp://ftp.in-berlin.de/pub/capi4linux/"
SRC_URI="ftp://ftp.in-berlin.de/pub/capi4linux/${MY_P}.tar.gz
	ftp://ftp.in-berlin.de/pub/capi4linux/OLD/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

DEPEND="virtual/linux-sources
	dev-lang/perl
	>=sys-apps/sed-4
	virtual/os-headers
	sys-devel/automake
	>=sys-devel/autoconf-2.50
	sys-devel/libtool"
RDEPEND=""

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A} || die "failed to unpack sources"
	cd ${S}
	# set our config
	cp -f ${FILESDIR}/config .config
	# patch includes of all *.c files
	sed -i -e "s:linux/capi.h>$:linux/compiler.h>\n#include <linux/capi.h>:g" */*.c || die "sed failed"
	# patch all Makefile.am and Rules.make to use our CFLAGS
	sed -i -e "s:^CFLAGS\(.*\)-O2:CFLAGS\1${CFLAGS}:g" */Makefile.am */Rules.make || die "sed failed"
	# patch capi20/Makefile.am to use -fPIC for shared library
	sed -i -e "s:^\(libcapi20_la_CFLAGS = \):\1-fPIC :g" capi20/Makefile.am || die "sed failed"
	# patch pppdcapiplugin/Makefile to use only the ppp versions we want
	sed -i -e "s:^\(PPPVERSIONS = \).*$:\1${PPPVERSIONS}:g" pppdcapiplugin/Makefile || die "sed failed"
	# patch capiinit/capiinit.c to look also in /lib/firmware
	sed -i -e "/\"\/usr\/share\/isdn\"/i\"/lib/firmware\"," capiinit/capiinit.c || die "sed failed"
}

src_compile() {
	# required by fPIC patch
	cd ${S}/capi20 || die "capi20 directory not found"
	ebegin "Updating autotools-generated files"
	aclocal -I . || die "aclocal failed"
	automake -a || die "automake failed"
	export WANT_AUTOCONF=2.5
	autoconf || die "autoconf failed"
	libtoolize -f -c || die "libtoolize failed"
	eend $?
	cd ${S}

	emake subconfig || die "make subconfig failed"
	emake || die "make failed"
}

src_install() {
	dodir /dev
	make DESTDIR=${D} install || die "make install failed"

	# install docs
	newdoc rcapid/README README.rcapid
	newdoc pppdcapiplugin/README README.pppdcapiplugin
	dodoc scripts/makedev.sh ${FILESDIR}/README.gentoo
	docinto pppdcapiplugin.examples; dodoc pppdcapiplugin/examples/*

	# install init-script + init-config
	dodir /etc/conf.d  # BUG: w/o newconfd failes
	newinitd ${FILESDIR}/capi.initd capi
	newconfd ${FILESDIR}/capi.confd capi

	# install USB hotplug stuff
	insinto /etc/hotplug/blacklist.d
	newins ${FILESDIR}/capi.blacklist capi
	insinto /etc/hotplug/usb
	newins ${FILESDIR}/capi.usermap capi.usermap
	exeinto /etc/hotplug/usb
	newexe ${FILESDIR}/capi.hotplug capi

	# example config
	insinto /etc
	insopts -m 0600
	doins ${FILESDIR}/capi.conf

	# rcapid config for xinetd
	insinto /etc/xinetd.d
	insopts -m 0644
	newins ${FILESDIR}/rcapid.xinetd rcapid

	# very useful tool ;-)
	dobin scripts/isdncause
}

pkg_postinst() {
	einfo "Please read the instructions in:"
	einfo "/usr/share/doc/${PF}/README.gentoo.gz"
	einfo ""
	einfo "Annotation for active AVM ISDN boards (B1 ISA/PCI, ...):"
	einfo "If you run"
	einfo "  emerge isdn-firmware"
	einfo "you will probably find your board's firmware in /lib/firmware."
	einfo ""
	einfo "If you have another active ISDN board, you should create"
	einfo "/lib/firmware and copy there your board's firmware."
}
