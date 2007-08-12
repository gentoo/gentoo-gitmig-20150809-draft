# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/lirc/lirc-0.8.2-r1.ebuild,v 1.1 2007/08/12 22:27:25 beandog Exp $

inherit eutils linux-mod flag-o-matic autotools

DESCRIPTION="decode and send infra-red signals of many commonly used remote controls"
HOMEPAGE="http://www.lirc.org/"

if [[ "${PV/_pre/}" = "${PV}" ]]; then
	SRC_URI="mirror://sourceforge/lirc/${P/_/}.tar.bz2"
else
	SRC_URI="http://lirc.sourceforge.net/software/snapshots/${P/_/}.tar.bz2"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug doc X hardware-carrier transmitter"

S=${WORKDIR}/${P/_pre/pre}

RDEPEND="
	X? (
		x11-libs/libX11
		x11-libs/libSM
		x11-libs/libICE
	)
	lirc_devices_alsa_usb? ( media-libs/alsa-lib )
	lirc_devices_audio? ( media-libs/portaudio )
	lirc_devices_irman? ( media-libs/libirman )"

# This are drivers with names matching the
# parameter --with-driver=NAME
IUSE_LIRC_DEVICES_DIRECT="
	all userspace accent act200l act220l
	adaptec alsa_usb animax asusdh atilibusb
	atiusb audio audio_alsa avermedia avermedia_vdomate
	avermedia98 bestbuy bestbuy2 breakoutbox
	bte bw6130 caraca chronos cmdir
	cph06x creative creative_infracd
	devinput digimatrix dsp dvico ea65
	exaudio flyvideo gvbctv5pci hauppauge
	hauppauge_dvb hercules_smarttv_stereo
	igorplugusb imon imon_pad imon_rsc
	irdeo irdeo_remote irman irreal it87
	knc_one kworld leadtek_0007 leadtek_0010
	leadtek_pvr2000 livedrive_midi
	livedrive_seq logitech macmini mceusb
	mceusb2 mediafocusI mouseremote
	mouseremote_ps2 mp3anywhere nslu2
	packard_bell parallel pcmak pcmak_usb
	pctv pixelview_bt878 pixelview_pak
	pixelview_pro provideo realmagic
	remotemaster sa1100 sasem sb0540 serial
	silitek sir slinke streamzap tekram
	tekram_bt829 tira ttusbir tuxbox tvbox udp uirt2
	uirt2_raw usb_uirt_raw usbx"

# drivers that need special handling and
# must have another name specified for
# parameter --with-driver=NAME
IUSE_LIRC_DEVICES_SPECIAL="
	imon_pad2keys serial_igor_cesko
	remote_wonder_plus xboxusb usbirboy inputlirc"

IUSE_LIRC_DEVICES="${IUSE_LIRC_DEVICES_DIRECT} ${IUSE_LIRC_DEVICES_SPECIAL}"

#device-driver which use libusb
LIBUSB_USED_BY_DEV="
	all atiusb sasem igorplugusb imon imon_pad imon_pad2keys
	imon_rsc streamzap mceusb mceusb2 xboxusb"

for dev in ${LIBUSB_USED_BY_DEV}; do
	RDEPEND="${RDEPEND} lirc_devices_${dev}? ( dev-libs/libusb )"
done

# adding only compile-time depends
DEPEND="${RDEPEND}
	virtual/linux-sources"

# adding only run-time depends
RDEPEND="${RDEPEND}
	lirc_devices_usbirboy? ( app-misc/usbirboy )
	lirc_devices_inputlirc? ( app-misc/inputlircd )"

# add all devices to IUSE
for dev in ${IUSE_LIRC_DEVICES}; do
	IUSE="${IUSE} lirc_devices_${dev}"
done

add_device() {
	((lirc_device_count++))

	if [[ ${lirc_device_count} -eq 2 ]]; then
		ewarn
		ewarn "When selecting multiple devices for lirc to be supported,"
		ewarn "it can not be garanteed that the drivers play nice together."
		ewarn
		ewarn "If this is not intended, then abort emerge now with Ctrl-C,"
		ewarn "Set LIRC_DEVICES and restart emerge."
		ewarn
		epause
	fi

	local dev="${1}"
	local desc="device ${dev}"
	if [[ -n "${2}" ]]; then
		desc="${2}"
	fi

	elog "Compiling support for ${desc}"
	MY_OPTS="${MY_OPTS} --with-driver=${dev}"
}

pkg_setup() {
	linux-mod_pkg_setup

	# set default configure options
	MY_OPTS=""
	lirc_driver_count=0

	LIRC_DRIVER_DEVICE="/dev/lirc/0"

	local dev

	if use lirc_devices_all; then
		# compile in drivers for a lot of devices
		add_device all "a lot of devices"
	else
		# compile in only requested drivers
		for dev in ${IUSE_LIRC_DEVICES_DIRECT}; do
			if use lirc_devices_${dev}; then
				add_device ${dev}
			fi
		done

		if use lirc_devices_remote_wonder_plus; then
			add_device atiusb "device Remote Wonder Plus (atiusb-based)"
		fi

		if use lirc_devices_serial_igor_cesko; then
			add_device serial "serial with Igor Cesko design"
			MY_OPTS="${MY_OPTS} --with-igor"
		fi

		if use lirc_devices_imon_pad2keys; then
			add_device imon_pad "device imon_pad (with converting pad input to keyspresses)"
		fi

		if use lirc_devices_xboxusb; then
			add_device atiusb "device xboxusb"
		fi

		if use lirc_devices_usbirboy; then
			add_device userspace "device usbirboy"
			LIRC_DRIVER_DEVICE="/dev/usbirboy"
		fi

		if [[ "${MY_OPTS}" == "" ]]; then
			if [[ "${PROFILE_ARCH}" == "xbox" ]]; then
				# on xbox: use special driver
				add_device atiusb "device xboxusb"
			else
				# no driver requested
				elog
				elog "Compiling only the lirc-applications, but no drivers."
				elog "Enable drivers with LIRC_DEVICES if you need them."
				MY_OPTS="--with-driver=userspace"
			fi
		fi
	fi

	use hardware-carrier && MY_OPTS="${MY_OPTS} --without-soft-carrier"
	use transmitter && MY_OPTS="${MY_OPTS} --with-transmitter"

	if [[ -n "${LIRC_OPTS}" ]] ; then
		ewarn
		ewarn "LIRC_OPTS is deprecated from lirc-0.8.0-r1 on."
		ewarn
		ewarn "Please use LIRC_DEVICES from now on."
		ewarn "e.g. LIRC_DEVICES=\"serial sir\""
		ewarn
		ewarn "Flags are now set per use-flags."
		ewarn "e.g. transmitter, hardware-carrier"

		local opt
		local unsupported_opts=""

		# test for allowed options for LIRC_OPTS
		for opt in ${LIRC_OPTS}; do
			case ${opt} in
				--with-port=*|--with-irq=*|--with-timer=*|--with-tty=*)
					MY_OPTS="${MY_OPTS} ${opt}"
					;;
				*)
					unsupported_opts="${unsupported_opts} ${opt}"
					;;
			esac
		done
		if [[ -n ${unsupported_opts} ]]; then
			ewarn "These options are no longer allowed to be set"
			ewarn "with LIRC_OPTS: ${unsupported_opts}"
			die "LIRC_OPTS is no longer recommended."
		fi
	fi

	# Setup parameter for linux-mod.eclass
	MODULE_NAMES="lirc(misc:${S})"
	BUILD_TARGETS="all"

	ECONF_PARAMS="	--localstatedir=/var
			        --with-syslog=LOG_DAEMON
			        --enable-sandboxed
	    		    --with-kerneldir=${KV_DIR}
			        --with-moduledir=/lib/modules/${KV_FULL}/misc
	    		    $(use_enable debug)
					$(use_with X x)
					${MY_OPTS}"

	einfo
	einfo "lirc-configure-opts: ${MY_OPTS}"
	elog  "Setting default lirc-device to ${LIRC_DRIVER_DEVICE}"

	filter-flags -Wl,-O1
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Rip out dos CRLF
	edos2unix contrib/lirc.rules

	# Apply patches needed for some special device-types
	use lirc_devices_imon_pad2keys && epatch ${FILESDIR}/${PN}-0.8.1-imon-pad2keys.patch
	use lirc_devices_remote_wonder_plus && epatch ${FILESDIR}/lirc-remotewonderplus.patch

	# bug 187822
	epatch "${FILESDIR}/lirc-0.8.2-kernel-2.6.22.patch"

	# remove parallel driver on SMP systems
	if linux_chkconfig_present SMP ; then
		sed -i -e "s:lirc_parallel\.o::" drivers/lirc_parallel/Makefile.am
	fi

	# respect CFLAGS
	sed -i -e 's:CFLAGS="-O2:CFLAGS=""\n#CFLAGS="-O2:' configure.in

	# setting default device-node
	sed -i -e '/#define LIRC_DRIVER_DEVICE/d' acconfig.h
	echo "#define LIRC_DRIVER_DEVICE \"${LIRC_DRIVER_DEVICE}\"" >> acconfig.h

	eautoreconf
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	newinitd ${FILESDIR}/lircd lircd
	newinitd ${FILESDIR}/lircmd lircmd
	newconfd ${FILESDIR}/lircd.conf lircd

	insinto /etc/modules.d/
	newins ${FILESDIR}/modulesd.lirc lirc

	newinitd ${FILESDIR}/irexec-initd irexec
	newconfd ${FILESDIR}/irexec-confd irexec

	insinto /etc/udev/rules.d/;
	newins ${S}/contrib/lirc.rules 10-lirc.rules

	if use doc ; then
		dohtml doc/html/*.html
		insinto /usr/share/doc/${PF}/images
		doins doc/images/*
	fi
}

pkg_preinst() {
	linux-mod_pkg_preinst
	[[ -f ${ROOT}/etc/lircd.conf ]] && cp "${ROOT}"/etc/lircd.conf "${D}"/etc/
}

pkg_postinst() {
	linux-mod_pkg_postinst
	echo
	elog "The lirc Linux Infrared Remote Control Package has been"
	elog "merged, please read the documentation at http://www.lirc.org"
	echo
}
