# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/capi4k-utils/capi4k-utils-20041006-r2.ebuild,v 1.1 2004/11/13 10:29:19 mrness Exp $

inherit eutils rpm

YEAR_PV=${PV:0:4}
MON_PV=${PV:4:2}
DAY_PV=${PV:6:2}

MY_FILES=${FILESDIR}/${PV}
MY_P=${PN}-${YEAR_PV}-${MON_PV}-${DAY_PV}
PPPVERSIONS="2.4.2"  # versions in portage

DESCRIPTION="CAPI4Linux Utils"
HOMEPAGE="ftp://ftp.in-berlin.de/pub/capi4linux/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""
S=${WORKDIR}/${PN}
SRC_URI="ftp://ftp.in-berlin.de/pub/capi4linux/${MY_P}.tar.gz
	ftp://ftp.in-berlin.de/pub/capi4linux/OLD/${MY_P}.tar.gz
	ftp://ftp.suse.com/pub/suse/i386/9.2/suse/src/i4l-base-2004.9.27-2.src.rpm"

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
	# set our config
	cp -f ${MY_FILES}/config .config
	# fix the little odd bugs
	epatch ${MY_FILES}/${PN}.patch || die "patch failed"
	# patch includes of all *.c files
	sed -i -e "s:linux/capi.h>$:linux/compiler.h>\n#include <linux/capi.h>:g" */*.c || die "sed failed"
	# patch all Makefile.am and Rules.make to use our CFLAGS
	sed -i -e "s:^CFLAGS\(.*\)-O2:CFLAGS\1${CFLAGS}:g" */Makefile.am */Rules.make || die "sed failed"
	# patch capi20/Makefile.am to use -fPIC for shared library
	sed -i -e "s:^\(libcapi20_la_CFLAGS = \):\1-fPIC :g" capi20/Makefile.am || die "sed failed"
	# patch pppdcapiplugin/Makefile to use only the ppp versions we want
	sed -i -e "s:^\(PPPVERSIONS = \).*$:\1${PPPVERSIONS}:g" pppdcapiplugin/Makefile || die "sed failed"
}

src_compile() {
	# required by fPIC patch
	cd ${S}/capi20 || die "capi20 directory not found"
	ebegin "Updating autotools-generated files"
	aclocal -I . || die "aclocal failed"
	automake -a || die "automake failed"
	autoconf || die "autoconf failed"
	libtoolize -f -c || die "libtoolize failed"
	eend $?
	cd ${S}

	emake subconfig || die "make subconfig failed"
	emake || die "make failed"
}

src_install() {
	dodir /dev
	emake DESTDIR=${D} install || die "make install failed"

	# install docs
	newdoc rcapid/README README.rcapid
	newdoc pppdcapiplugin/README README.pppdcapiplugin
	dodoc scripts/makedev.sh ${MY_FILES}/README.gentoo
	docinto pppdcapiplugin.examples; dodoc pppdcapiplugin/examples/*

	# install init-script
	newinitd ${FILESDIR}/${PV}/capi.init capi

	# example config
	insinto /etc
	insopts -m 0600
	doins capiinit/capi.conf

	# rcapid config for xinetd
	insinto /etc/xinetd.d
	insopts -m 0644
	newins ${FILESDIR}/${PV}/rcapid.xinetd rcapid

	# very useful tool ;-)
	dobin scripts/isdncause

	# install AVM firmware files
	insinto /usr/share/isdn
	insopts -m 0444
	doins ${WORKDIR}/i4l_suse/firm/{*.t4,*.frm,c[24].bin}
}

pkg_postinst() {
	einfo "Please read the instructions in:"
	einfo "/usr/share/doc/${PN}/README.gentoo.gz"
	einfo ""
	einfo "Annotation for active AVM ISDN boards (B1 ISA/PCI, ...):"
	einfo "This ebuild has installed a bunch of firmware files"
	einfo "which are to be found in /usr/share/isdn"
}
