# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/ivtv/ivtv-0.2.0_rc2.ebuild,v 1.2 2004/12/05 02:01:11 iggy Exp $

# TODO
# the "Gentoo way" is to use /usr/src/linux, not the running kernel
# check for other msp3400 modules
# add a few notes to the postinst output about what's needed (bttv/tuner, etc.)

inherit eutils

DESCRIPTION="ivtv driver for Hauppauge PVR[23]50 cards"
HOMEPAGE="http://ivtv.sourceforge.net"

# stupidly named tarballs
MY_P="${P/_/-}f"

SRC_URI="http://205.209.168.201/~ckennedy/ivtv/${MY_P}.tgz
	http://hauppauge.lightpath.net/software/pvr250/pvr250_18a_inf.zip"

RESTRICT="nomirror"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

[ "`echo ${KV} | cut -f2 -d.`" == 6 ] && SANDBOX_DISABLED="1"

IUSE="lirc"

DEPEND="app-arch/unzip
	lirc? ( app-misc/lirc )"

src_unpack() {
	unpack ${MY_P}.tgz
	cd ${WORKDIR}/${MY_P}/driver
	sed -i -e 's:$(MODDIR):$(DESTDIR)/$(MODDIR):g' \
		-e 's:$(INCLUDEDIR):$(DESTDIR)/$(INCLUDEDIR):g' \
		Makefile2.4 || die "sed failed"
}

src_compile() {
	set_arch_to_kernel

	cd ${WORKDIR}/${MY_P}/driver
	make || die "build of driver failed"

	cd ${WORKDIR}/${MY_P}/utils
	make ||  die "build of utils failed"
}

src_install() {
	cd ${WORKDIR}/${MY_P}/utils
	cp ${DISTDIR}/pvr250_18a_inf.zip .
	dodir /lib/modules
	touch ${D}/lib/modules/ivtv-fw-{enc,dec}.bin
	./ivtvfwextract.pl pvr250_18a_inf.zip \
		${D}/lib/modules/ivtv-fw-enc.bin \
		${D}/lib/modules/ivtv-fw-dec.bin

	cd ${WORKDIR}/${MY_P}
	dodoc README doc/*

	cd ${WORKDIR}/${MY_P}/utils
	newbin encoder ivtv-encoder
	newbin fwapi ivtv-fwapi
	newbin radio ivtv-radio
	newbin vbi ivtv-vbi
	newbin mpegindex ivtv-mpegindex
	dobin ivtvfbctl ivtvplay ivtvctl
	newdoc README README.utils
	dodoc README.mythtv-ivtv README.radio README.vbi zvbi.diff
	dodoc lircd-g.conf lircd.conf lircrc

	# for whatever reason, the Makefile doesn't make the dirs we need
	# fixes bug # 68110
	dodir /usr/include/linux
	dodir /lib/modules/`uname -r`/extra
	cd ${WORKDIR}/${MY_P}/driver
	make DESTDIR=${D} INSTALL_MOD_PATH=${D} \
		install || die "installation of driver failed"

	set_arch_to_portage

	dodir /etc/modules.d

	echo "alias char-major-81     videodev" >>${D}/etc/modules.d/ivtv
	echo "alias char-major-81-0   ivtv" >>${D}/etc/modules.d/ivtv

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
	einfo "You'll now need an application to watch tv. "
	einfo "To get the ir remote working, you'll need to emerge lirc"
	einfo "with the following env variable set:"
	einfo "LIRC_OPTS=\"--with-x --with-driver=hauppauge --with-major=61"
	einfo "	--with-port=none --with-irq=none\""
	einfo "see http://ivtv.sourceforge.net for more info"
	echo
	einfo "to use vbi, you'll need a few other things, check README.vbi in the docs dir"
	echo
	einfo "you'll also need to add 'LIRCD_OPTS=\"--device=/dev/lirc/0\"' to /etc/conf.d/lircd"
	echo
	einfo "The ptune* scripts have moved to media-tv/ivtv-ptune, emerge that to use those scripts"

	if [ -f "/lib/modules/`uname -r`/kernel/drivers/media/video/msp3400.ko" ] ; then
		ewarn "You have the msp3400 module that comes with the kernel. It isn't compatible"
		ewarn "with ivtv. You need to back it up to somewhere else, then run depmod -ae again"
	fi
}
