# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/capi4k-utils/capi4k-utils-20041006-r1.ebuild,v 1.1 2004/11/10 22:39:56 mrness Exp $

inherit eutils rpm

YEAR_PV=${PV:0:4}
MON_PV=${PV:4:2}
DAY_PV=${PV:6:2}

MY_P=${PN}-${YEAR_PV}-${MON_PV}-${DAY_PV}
AVM_FIRMWARE_PREFIX="ftp://ftp.quicknet.nl/pub/Linux/mungo.homelinux.org/files/current/all/noarch/capi-firmware-avm-"
AVM_FIRMWARE_SUFFIX=".noarch.rpm"

DESCRIPTION="Capi4Linux Utils"
HOMEPAGE="ftp://ftp.in-berlin.de/pub/capi4linux/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""
S=${WORKDIR}/${PN}
SRC_URI="ftp://ftp.in-berlin.de/pub/capi4linux/${MY_P}.tar.gz ftp://ftp.in-berlin.de/pub/capi4linux/OLD/${MY_P}.tar.gz
	${AVM_FIRMWARE_PREFIX}b1-3.11.03-4${AVM_FIRMWARE_SUFFIX}
	${AVM_FIRMWARE_PREFIX}c2-3.11.04-4${AVM_FIRMWARE_SUFFIX}
	${AVM_FIRMWARE_PREFIX}c4-3.11.04-4${AVM_FIRMWARE_SUFFIX}
	${AVM_FIRMWARE_PREFIX}t1-3.09.07-4${AVM_FIRMWARE_SUFFIX}"

DEPEND="virtual/linux-sources
	dev-lang/perl
	>=sys-apps/sed-4
	virtual/os-headers
	sys-devel/automake
	sys-devel/autoconf
	sys-devel/libtool
	app-arch/rpm"

RDEPEND=""

src_unpack() {
	rpm_src_unpack || die "failed to unpack sources or firmware files"
	cd ${S}
	epatch ${FILESDIR}/${MY_P}.patch || die "patch failed"
	epatch ${FILESDIR}/${MY_P}-fPIC.patch || die "patch failed"
	sed -i -e 's:linux/capi.h>$:linux/compiler.h>\n#include <linux/capi.h>:g' */*.c || die "sed failed"
	sed -i -e "s:^CFLAGS\(.*\)-O2:CFLAGS\1${CFLAGS}:g" */Makefile.am || die "sed failed"
}

src_compile() {
	# required by fPIC patch
	cd ${S}/capi20 || die
	ebegin "Updating autotools-generated files"
	aclocal -I . || die "aclocal failed"
	automake -a || die "automake failed"
	autoconf || die "autoconf failed"
	libtoolize -f -c || die "libtoolize failed"
	eend $?
	cd ${S} || die

	emake subconfig || die
	emake || die
}

src_install() {
	dodir /dev
	emake DESTDIR=${D} install || die
	rm -rf ${D}/dev
	newdoc rcapid/README README.rcapid
	newdoc pppdcapiplugin/README README.pppdcapiplugin
	docinto examples.pppdcapiplugin; dodoc pppdcapiplugin/examples/*
	newinitd ${FILESDIR}/capi-init-${PV} capi
	insinto /etc
	insopts -m 0600
	doins capiinit/capi.conf

	#install AVM firmware files
	insinto /usr/share/isdn
	insopts -m 0444
	doins ${WORKDIR}/usr/share/isdn/*
}

pkg_postinst() {
	einfo "To use isdn4linux with CAPI replace"
	einfo "I4L_MODULE=\"hisax\" with I4L_MODULE=\"capidrv\","
	einfo "start /etc/init.d/capi and load the module"
	einfo "capidrv."
	einfo ""
	einfo "Annotation for active AVM ISDN boards (B1 ISA/PCI, ...):"
	einfo "   This ebuild has installed a bunch of firmware files"
	einfo "   which are to be found in /usr/share/isdn"
}
