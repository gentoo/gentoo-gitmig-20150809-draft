# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/ivtv/ivtv-0.1.9-r2.ebuild,v 1.2 2004/03/24 17:03:12 mholzer Exp $

# TODO
# the "Gentoo way" is to use /usr/src/linux, not the running kernel
# make it detect whether it's a 2.6 kernel and patch if necessary

inherit eutils

DESCRIPTION="ivtv driver for Hauppauge PVR[23]50 cards"
HOMEPAGE="http://ivtv.sourceforge.net"

SRC_URI="mirror://sourceforge/ivtv/${P}.tar.gz
	http://hauppauge.lightpath.net/software/pvr250/pvr250_17_21288.exe
	mirror://gentoo/${PF}.patch"

RESTRICT="nomirror"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

IUSE="lirc"

DEPEND="lirc? ( app-misc/lirc )"

src_unpack() {
	unpack ${P}.tar.gz

	cd ${WORKDIR}/ivtv
	epatch ${DISTDIR}/${PF}.patch || die "${PF} patch failed"
	sed -i -e 's:include <linux/videodev2.h>:include "videodev2.h":' utils/radio.c
}

src_compile() {
#	if `grep -q I2C_VERSION.*2\.8 /usr/src/linux/include/linux/i2c.h` ;then
#		einfo "found new i2c in your kernel source"
#		sed -i -e \
#			's:^#CFLAGS += -DNEW_I2C:CFLAGS += -DNEW_I2C:' \
#			${WORKDIR}/ivtv/driver/Makefile
#	fi

	cd ${WORKDIR}/ivtv/driver
	make || die "build of driver failed"

	cd ${WORKDIR}/ivtv/utils
	make ||  die "build of utils failed"
}

src_install() {
	cd ${WORKDIR}/ivtv/utils
	cp ${DISTDIR}/pvr250_17_21288.exe .
	dodir /lib/modules
	touch ${D}/lib/modules/ivtv-{enc,dec}-fw.bin
	./ivtvfwextract.pl pvr250_17_21288.exe \
		${D}/lib/modules/ivtv-fw-enc.bin \
		${D}/lib/modules/ivtv-fw-dec.bin

	cd ${WORKDIR}/ivtv
	dodoc README doc/*

	cd ${WORKDIR}/ivtv/utils
	dobin test_ioctl ivtvfbctl ivtvplay ptune-ui.pl ptune.pl record-v4l2.pl
	dobin radio vbi mpegindex
	newdoc README README.utils
	dodoc README.mythtv-ivtv README.ptune README.radio README.vbi zvbi.diff
	dodoc lircd-g.conf lircd.conf lircrc

	cd ${WORKDIR}/ivtv/driver
	make DESTDIR=${D} install || die "installation of driver failed"

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

	if [ `has app-misc/lirc` ] || [ `use lirc` ] ; then
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
	einfo "to use vbi, you'll need a few other things, check README.vbi in the docs dir"
}
