# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/lirc/lirc-0.8.0.ebuild,v 1.4 2006/04/14 23:22:47 zzam Exp $

inherit eutils linux-mod flag-o-matic autotools

DESCRIPTION="LIRC is a package that allows you to decode and send infra-red \
	signals of many (but not all) commonly used remote controls."
HOMEPAGE="http://www.lirc.org"

SLOT="0"
LICENSE="GPL-2"
IUSE="alsa debug doc X usb"
KEYWORDS="x86 ~ppc ~alpha ~ia64 ~amd64 ~ppc64"

RDEPEND="virtual/libc
	virtual/modutils
	sys-apps/coreutils
	alsa? ( media-libs/alsa-lib )
	usb? ( dev-libs/libusb )
	X? ( || ( (	x11-libs/libX11
			x11-libs/libSM
			x11-libs/libICE )
	virtual/x11 ) )"

DEPEND="${RDEPEND}
	sys-kernel/linux-headers
	sys-devel/autoconf
	sys-devel/libtool"

SRC_URI="mirror://sourceforge/lirc/${P/_pre/pre}.tar.bz2"
#SRC_URI="http://lirc.sourceforge.net/software/snapshots/lirc-0.8.0pre3.tar.bz2"

S=${WORKDIR}/${P/_pre/pre}

pkg_setup() {
	linux-mod_pkg_setup

	if [ "x${LIRC_OPTS}" = x ] ; then
		echo
		ewarn "By default this package will not compile a driver for your hardware"
		ewarn "unless you specify LIRC_OPTS. The best place to save this is in"
		ewarn "/etc/make.conf"
		ewarn "For example, PVR-x50 users should add the following to /etc/make.conf"
		ewarn "LIRC_OPTS=\"--with-driver=hauppauge\""
		echo
		ewarn "Possible options are listed below:"
		echo
		cat <<-EOF
# You have to know, which driver you want;
# --with-driver=X

# where X is one of:
# none, all, act200l, animax, atilibusb, atiusb, audio, avermedia, avermedia_vdomate,
# avermedia98, bestbuy, bestbuy2, breakoutbox, bte, caraca, chronos, comX,
# creative_infracd, dsp, cph03x, cph06x, creative, devinput, exaudio, flyvideo,
# gvbctv5pci, hauppauge, hauppauge_dvb, hercules_smarttv_stereo, igorplugusb, irdeo,
# irdeo_remote, irman, irreal, it87, knc_one, kworld, leadtek_0007, leadtek_0010,
# livedrive_midi, livedrive_seq, logitech, lptX, mceusb, mediafocusI, mp3anywhere,
# packard_bell, parallel, pcmak, pcmak_usb, pctv, pixelview_bt878, pixelview_pak,
# pixelview_pro, provideo, realmagic, remotemaster, sa1100, sasem, serial,
# silitek, sir, slinke, tekram, tekram_bt829, tira, tvbox, udp, uirt2, uirt2_raw
# winfast_tv2000 is now leadtek_0010, streamzap

# This could be useful too

# --with-port=port      # port number for the lirc device.
# --with-irq=irq        # irq line for the lirc device.
# --with-timer=value    # timer value for the parallel driver
# --with-tty=file       # tty to use (Irman, RemoteMaster, etc.)
# --without-soft-carrier        # if your serial hw generates carrier

# --with-port=port      # port number for the lirc device.
# --with-irq=irq        # irq line for the lirc device.
# --with-timer=value    # timer value for the parallel driver
# --with-tty=file       # tty to use (Irman, RemoteMaster, etc.)
# --without-soft-carrier        # if your serial hw generates carrier
# --with-transmitter    # if you use a transmitter diode
		EOF
		sleep 5
	fi

	export WANT_AUTOCONF=2.5
}

src_unpack() {
	unpack ${A}
	cd ${S}
	#epatch ${FILESDIR}/lirc-0.7.0-xbox.patch.bz2
	epatch ${FILESDIR}/${P}-kernel-2.6.16.diff

	filter-flags -Wl,-O1
	sed -i -e 's:CFLAGS="-O2:CFLAGS=""\n#CFLAGS="-O2:' configure.in

	eautoreconf || "autoreconf failed"
}


src_compile() {
	get_version

	# set default configure options
	[ "x${LIRC_OPTS}" = x ] && [ "${PROFILE_ARCH}" == "xbox" ] && \
		LIRC_OPTS="--with-driver=xboxusb"
	[ "x${LIRC_OPTS}" = x ] && LIRC_OPTS="--with-driver=none"

	# remove parallel driver on SMP systems
	if linux_chkconfig_present SMP ; then
		sed -i -e "s:lirc_parallel::" drivers/Makefile.in
	fi

	unset ARCH

	econf \
		--localstatedir=/var \
		--with-syslog=LOG_DAEMON \
		--enable-sandboxed \
		--with-kerneldir=${KV_DIR} \
		--with-moduledir=/lib/modules/${KV_FULL}/misc \
		`use_enable debug` \
		`use_with X` \
		${LIRC_OPTS} || die "./configure failed"

	emake || die "compile failed"

}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	newinitd ${FILESDIR}/lircd lircd
	newinitd ${FILESDIR}/lircmd lircmd
	newconfd ${FILESDIR}/lircd.conf lircd

	has_version sys-fs/udev && (
		insinto /etc/udev/rules.d/;
		newins ${S}/contrib/lirc.rules 10-lirc.rules )

	if use doc ; then
		dohtml doc/html/*.html
		insinto /usr/share/doc/${PF}/images
		doins doc/images/*
	fi
}

pkg_preinst() {
	[ -f "${ROOT}/etc/lircd.conf" ] && cp ${ROOT}/etc/lircd.conf ${IMAGE}/etc
}

pkg_postinst() {
	linux-mod_pkg_postinst
	echo
	einfo "The lirc Linux Infrared Remote Control Package has been"
	einfo "merged, please read the documentation at http://www.lirc.org"
	echo
}
