# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/ivtv/ivtv-0.1.9-r4.ebuild,v 1.2 2004/09/02 15:21:32 iggy Exp $

# TODO
# the "Gentoo way" is to use /usr/src/linux, not the running kernel
# removed ptune*.pl, need to make a seperate package for it

# hackish I know
ETYPE="headers"

inherit eutils kernel

DESCRIPTION="ivtv driver for Hauppauge PVR[23]50 cards"
HOMEPAGE="http://ivtv.sourceforge.net"

SRC_URI="mirror://gentoo/${P}-${PR}.tar.bz2
	http://hauppauge.lightpath.net/software/pvr250/pvr250_18a_inf.zip"

RESTRICT="nomirror"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

[ "`echo ${KV} | cut -f2 -d.`" == 6 ] && SANDBOX_DISABLED="1"

IUSE="lirc"

DEPEND="lirc? ( app-misc/lirc )
	app-arch/unzip"

src_unpack() {
	unpack ${P}-${PR}.tar.bz2
}

src_compile() {
	set_arch_to_kernel

	cd ${WORKDIR}/${P}-${PR}/driver
	make || die "build of driver failed"

	cd ${WORKDIR}/${P}-${PR}/utils
	make ||  die "build of utils failed"
}

src_install() {
	cd ${WORKDIR}/${P}-${PR}/utils
	cp ${DISTDIR}/pvr250_18a_inf.zip .
	dodir /lib/modules
	touch ${D}/lib/modules/ivtv-fw-{enc,dec}.bin
	./ivtvfwextract.pl pvr250_18a_inf.zip \
		${D}/lib/modules/ivtv-fw-enc.bin \
		${D}/lib/modules/ivtv-fw-dec.bin

	cd ${WORKDIR}/${P}-${PR}
	dodoc README doc/*

	cd ${WORKDIR}/${P}-${PR}/utils
	newbin test_ioctl ivtvctl
	newbin encoder ivtv-encoder
	newbin fwapi ivtv-fwapi
	newbin radio ivtv-radio
	newbin vbi ivtv-vbi
	newbin mpegindex ivtv-mpegindex
	dobin ivtvfbctl ivtvplay
	newdoc README README.utils
	dodoc README.mythtv-ivtv README.radio README.vbi zvbi.diff
	dodoc lircd-g.conf lircd.conf lircrc

	cd ${WORKDIR}/${P}-${PR}/driver
	make DESTDIR=${D} install || die "installation of driver failed"

	set_arch_to_portage

	dodir /etc/modules.d

	echo <<-myEOF >>${D}/etc/modules.d/ivtv
	alias char-major-81     videodev
	alias char-major-81-0   ivtv
	options ivtv debug=1
	options tuner type=2
	options saa7127 enable_output=1 output_select=0
	options msp3400 once=1 simple=1
	add below ivtv msp3400 saa7115 tuner
	post-install ivtv /usr/local/bin/test_ioctl -d /dev/video0 -u 0x3000
	myEOF

	if [ `has app-misc/lirc` ] || use lirc ; then
		echo "alias char-major-61 lirc_i2c" >> ${D}/etc/modules.d/ivtv
		echo "add above ivtv lirc_dev lirc_i2c" >> ${D}/etc/modules.d/ivtv
	else
		einfo "Not enabling lirc support. emerge lirc to get it."
	fi

}

pkg_postinst() {
	depmod -ae

	einfo "You now have the driver for the Hauppauge PVR-[23]50 cards."
	einfo "Add ivtv to /etc/modules.autoload.d/kernel-2.X"
	einfo "You'll now need an application to watch tv. MythTV is the only choice at"
	einfo "the moment. To get the ir remote working, you'll need to emerge lirc"
	einfo "with the following env variable set:"
	einfo "LIRC_OPTS=\"--with-x --with-driver=hauppauge --with-major=61"
	einfo "	--with-port=none --with-irq=none\""
	einfo "see http://ivtv.sourceforge.net for more info"
	echo
	einfo "to use vbi, you'll need a few other things, check README.vbi in the docs dir"
	echo
	einfo "you'll also need to add 'LIRCD_OPTS=\"--device=/dev/lirc/0\"' to /etc/conf.d/lircd"

	if [ -f "/lib/modules/`uname -r`/kernel/drivers/media/video/msp3400.ko" ] ; then
		ewarn "You have the msp3400 module that comes with the kernel. It isn't compatible"
		ewarn "with ivtv. You need to back it up to somewhere else, then run depmod -ae again"
	fi
}
