# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/linuxtv-dvb/linuxtv-dvb-1.0.1.ebuild,v 1.3 2004/02/17 21:50:32 agriffis Exp $

DESCRIPTION="Standalone DVB driver for Linux kernel 2.4.x"
HOMEPAGE="http://www.linuxtv.org"
SRC_URI="http://www.linuxtv.org/download/dvb/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~alpha ~ia64"
IUSE=""
DEPEND="virtual/linux-sources"
#RDEPEND=""
S=${WORKDIR}/${P}

pkg_setup() {
	einfo ""
	einfo "Please make sure that the following option is enabled"
	einfo "in your current kernel 'Multimedia devices'"
	einfo "and /usr/src/linux point's to your current kernel"
	einfo "or make will die."
	einfo ""
}

src_compile() {
	emake
}

src_install() {
	# install the driver
	cd ${S}/driver
	mv Makefile Makefile.orig
	# don't run depmod now!
	sed s/'depmod'/'#depmod'/ Makefile.orig > Makefile
	make DESTDIR=${D} install || die

	# install av7110_loadkeys
	dobin ${S}/apps/av7110_loadkeys/av7110_loadkeys \
		${S}/apps/av7110_loadkeys/evtest

	# install dvbnet
	cd ${S}/apps/dvbnet
	make DESTDIR=${D}usr/bin install || die

	# install scan
	dobin ${S}/apps/scan/scan

	# install szap
	dobin ${S}/apps/szap/[tsc]zap
	dodoc ${S}/apps/szap/channels.conf-dvb*

	# 'install' test
	dodir /usr/share/doc/${P}/test
	insinto /usr/share/doc/${P}/test
	doins ${S}/apps/test/*

	# install headers
	dodir /usr/include/linux
	insinto /usr/include/linux
	doins ${S}/include/linux/em8300.h

	dodir /usr/include/linux/dvb
	insinto /usr/include/linux/dvb
	doins ${S}/include/linux/dvb/*.h

	# install docs
	dodoc ${S}/doc/*
	dodoc ${S}/driver/makedev.napi
	dodir /usr/share/doc/${P}/dvbapi
	insinto /usr/share/doc/${P}/dvbapi
	doins ${S}/doc/dvbapi/*

	# install av7110_loadkeys docs
	dodir /usr/share/doc/${P}/av7110_loadkeys
	insinto /usr/share/doc/${P}/av7110_loadkeys
	cd ${S}/apps/av7110_loadkeys
	doins README *.rc5 *.rcmm

	# install dvbnet scripts
	dodir /usr/share/doc/${P}/dvbnet
	insinto /usr/share/doc/${P}/dvbnet
	doins ${S}/apps/dvbnet/net_start.*

	# install scan docs
	dodir /usr/share/doc/${P}/scan
	insinto /usr/share/doc/${P}/scan
	doins ${S}/apps/scan/README

	# install test docs
	dodir /usr/share/doc/${P}/test
	insinto /usr/share/doc/${P}/test
	doins ${S}/apps/test/README

	cd ${S}
	dodoc CONTRIBUTORS COPYING INSTALL README NEWS BUGS
	dodoc ${FILESDIR}/dvb

}

pkg_postinst() {
	depmod -a
	einfo ""
	einfo "If you don't use devfs, execute makedev.napi o create"
	einfo "the device nodes. The file is in /usr/share/doc/${PF}/"
	einfo ""
	einfo "now copy an appropriate from"
	einfo "/usr/share/doc/${PF}/channels.conf-XXX"
	einfo "channel list for DVB-S/C/T"
	einfo "		to ~/.szap/channels.conf"
	einfo "		~/.czap/channels.conf"
	einfo "		~/.tzap/channels.conf"
	einfo "and then call szap for DVB-S, czap for DVB-C or tzap for DVB-T"
	einfo ""
	einfo "If you'd like to load all modules at once, unpack and add"
	einfo "/usr/share/doc/${PF}/dvb.gz to /etc/modules.d/"
	einfo "then run #update-modules to update your modules.conf"
	einfo ""
}

pkg_postrm() {
	depmod -a
}
