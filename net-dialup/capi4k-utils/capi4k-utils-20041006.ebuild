# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/capi4k-utils/capi4k-utils-20041006.ebuild,v 1.1 2004/10/30 13:13:58 dragonheart Exp $

inherit eutils

YEAR_PV=${PV:0:4}
MON_PV=${PV:4:2}
DAY_PV=${PV:6:2}

MY_P=${PN}-${YEAR_PV}-${MON_PV}-${DAY_PV}

S=${WORKDIR}/${PN}
DESCRIPTION="Capi4Linux Utils"
SRC_URI="ftp://ftp.in-berlin.de/pub/capi4linux/${MY_P}.tar.gz ftp://ftp.in-berlin.de/pub/capi4linux/OLD/${MY_P}.tar.gz"
HOMEPAGE="ftp://ftp.in-berlin.de/pub/capi4linux/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/linux-sources
	dev-lang/perl
	>=sys-apps/sed-4
	virtual/os-headers
	sys-devel/automake
	sys-devel/autoconf
	sys-devel/libtool
	>=sys-apps/sed-4"

RDEPEND=""

src_unpack() {
	unpack ${A}
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
}

pkg_postinst() {
	einfo "To use isdn4linux with CAPI replace"
	einfo "I4L_MODULE=\"hisax\" with I4L_MODULE=\"capidrv\","
	einfo "start /etc/init.d/capi and load the module"
	einfo "capidrv."
	einfo ""
	einfo "Annotation for active AVM ISDN boards (B1 ISA/PCI, ...):"
	einfo "Please download the latest firmware from"
	einfo "ftp://ftp.in-berlin.de/pub/capi4linux and copy the files "
	einfo "to /usr/lib/isdn and check your /etc/capi.conf file"
	einfo ""
}
