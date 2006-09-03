# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/lirc/lirc-0.8.0-r5.ebuild,v 1.3 2006/09/03 19:48:17 blubb Exp $

inherit eutils linux-mod flag-o-matic autotools

DESCRIPTION="LIRC is a package that allows you to decode and send infra-red \
	signals of many (but not all) commonly used remote controls."
HOMEPAGE="http://www.lirc.org"

SLOT="0"
LICENSE="GPL-2"
IUSE="alsa debug doc X usb hardware-carrier transmitter udev"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
SRC_URI="mirror://sourceforge/lirc/${P/_pre/pre}.tar.bz2"

S=${WORKDIR}/${P/_pre/pre}


IUSE_LIRC_DEVICES_DIRECT="
	all userspace act200l act220l
	adaptec alsa_usb animax atilibusb
	atiusb audio audio_alsa avermedia avermedia_vdomate
	avermedia98 bestbuy bestbuy2 breakoutbox
	bte bw6130 caraca chronos cmdir com1 com2 com3 com4
	cph06x creative creative_infracd
	devinput digimatrix dsp dvico ea65
	exaudio flyvideo gvbctv5pci hauppauge
	hauppauge_dvb hercules_smarttv_stereo
	igorplugusb imon imon_pad imon_rsc
	irdeo irdeo_remote irman irreal it87
	knc_one kworld leadtek_0007 leadtek_0010
	leadtek_pvr2000 livedrive_midi
	livedrive_seq logitech lpt1 lpt2 mceusb
	mceusb2 mediafocusI mouseremote
	mouseremote_ps2 mp3anywhere nslu2
	packard_bell parallel pcmak pcmak_usb
	pctv pixelview_bt878 pixelview_pak
	pixelview_pro provideo realmagic
	remotemaster sa1100 sasem serial
	silitek sir slinke streamzap tekram
	tekram_bt829 tira tvbox udp uirt2
	uirt2_raw"

IUSE_LIRC_DEVICES_SPECIAL="imon_pad2keys serial_igor_cesko xboxusb usbirboy"
IUSE_LIRC_DEVICES="${IUSE_LIRC_DEVICES_DIRECT} ${IUSE_LIRC_DEVICES_SPECIAL}"



RDEPEND="virtual/libc
	sys-apps/coreutils
	X? ( || ( (	x11-libs/libX11
			x11-libs/libSM
			x11-libs/libICE )
	virtual/x11 ) )
	lirc_devices_alsa_usb? ( media-libs/alsa-lib )
	lirc_devices_audio? ( media-libs/portaudio )
	lirc_devices_irman? ( media-libs/libirman )"


#device-driver which use libusb
LIBUSB_USED_BY_DEV="
	all atiusb sasem igorplugusb imon imon_pad imon_pad2keys
	imon_rsc streamzap mceusb mceusb2 xboxusb"

for dev in ${LIBUSB_USED_BY_DEV}; do
	RDEPEND="${RDEPEND} lirc_devices_${dev}? ( dev-libs/libusb )"
done

# adding only compile-time depends
DEPEND="${RDEPEND}
	virtual/linux-sources
	sys-devel/autoconf
	sys-devel/libtool"


# adding only run-time depends
RDEPEND="${RDEPEND}
	lirc_devices_usbirboy? ( app-misc/usbirboy )"



# add all devices to IUSE
for dev in ${IUSE_LIRC_DEVICES}; do
	IUSE="${IUSE} lirc_devices_${dev}"
done


add_device() {
	: $(( lirc_device_count++ ))

	if [[ ${lirc_device_count} -eq 2 ]]; then
		ewarn
		#ewarn "When selecting multiple devices for lirc to be supported,"
		#ewarn "it can not be garanteed that the drivers play nice together."
		ewarn "lirc does at the moment support only one driver be compiled at a time."
		ewarn "Please reduce LIRC_DEVICES to one item."
		die "Multiple drivers selected for lirc."
	fi


	local dev="${1}"
	local desc="device ${dev}"
	if [[ -n "${2}" ]]; then
		desc="${2}"
	fi

	einfo "Compiling support for ${desc}"
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

		if use lirc_devices_serial_igor_cesko; then
			add_device serial "serial with Igor Cesko design"
			MY_OPTS="${MY_OPTS} --with-igor"
		fi

		if use lirc_devices_imon_pad2keys; then
			add_device imon_pad "device imon_pad (with converting pad input to keyspresses)"
		fi

		if use lirc_devices_xboxusb; then
			add_device atiusb "device xboxusb"
			NEED_XBOX_PATCH=1
		fi

		if use lirc_devices_usbirboy; then
			add_device userspace "device usbirboy"
			LIRC_DRIVER_DEVICE="/dev/usbirboy"
		fi

		if [[ "${MY_OPTS}" == "" ]]; then
			if [[ "${PROFILE_ARCH}" == "xbox" ]]; then
				# on xbox: use special driver
				add_device atiusb "device xboxusb"
				NEED_XBOX_PATCH=1
			else
				# no driver requested
				einfo
				einfo "Compiling only the lirc-applications, but no drivers."
				einfo "Enable drivers with LIRC_DEVICES if you need them."
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
					$(use_with X)
					${MY_OPTS}"

	einfo
	einfo "lirc-configure-opts: ${MY_OPTS}"
	einfo "Setting default lirc-device to ${LIRC_DRIVER_DEVICE}"

	export WANT_AUTOCONF=2.5
	filter-flags -Wl,-O1
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# Apply kernel compatibility patches
	epatch ${FILESDIR}/${P}-kernel-2.6.16.diff
	epatch ${FILESDIR}/${P}-kernel-2.6.17.diff
	epatch ${FILESDIR}/${P}-kernel-2.6.18.diff

	# Work with udev-094 and greater
	epatch ${FILESDIR}/${PN}-udev-094.diff

	# Bugfix for i2c-driver in combination with newer ivtv and Kernel 2.6.17
	epatch ${FILESDIR}/${P}-i2c-kernel-2.6.17.diff

	# Wrong config-filename for LIRC_DEVICES=pixelview_bt878
	epatch ${FILESDIR}/${P}-conf-pixelview_bt878.diff

	# Apply patches needed for some special device-types
	[[ ${NEED_XBOX_PATCH:-0} == 1 ]] && epatch ${FILESDIR}/lirc-0.8.0pre4-xbox-remote.diff
	use lirc_devices_imon_pad2keys && epatch ${FILESDIR}/${P}-imon-pad2keys.patch

	# remove parallel driver on SMP systems
	if linux_chkconfig_present SMP ; then
		sed -i -e "s:lirc_parallel::" drivers/Makefile.in
	fi

	# respect CFLAGS
	sed -i -e 's:CFLAGS="-O2:CFLAGS=""\n#CFLAGS="-O2:' configure.in

	# setting default device-node
	sed -i -e '/#define LIRC_DRIVER_DEVICE/d' acconfig.h
	echo "#define LIRC_DRIVER_DEVICE \"${LIRC_DRIVER_DEVICE}\"" >> acconfig.h

	eautoreconf || die "autoreconf failed"
}


src_install() {
	make DESTDIR=${D} install || die "make install failed"

	newinitd ${FILESDIR}/lircd lircd
	newinitd ${FILESDIR}/lircmd lircmd
	newconfd ${FILESDIR}/lircd.conf lircd

	insinto /etc/modules.d/
	newins ${FILESDIR}/modulesd.lirc lirc

	if use udev; then
		insinto /etc/udev/rules.d/;
		newins ${S}/contrib/lirc.rules 10-lirc.rules
	fi

	if use doc ; then
		dohtml doc/html/*.html
		insinto /usr/share/doc/${PF}/images
		doins doc/images/*
	fi
}

pkg_preinst() {
	linux-mod_pkg_preinst
	[[ -f "${ROOT}/etc/lircd.conf" ]] && cp ${ROOT}/etc/lircd.conf ${IMAGE}/etc
}

pkg_postinst() {
	linux-mod_pkg_postinst
	echo
	einfo "The lirc Linux Infrared Remote Control Package has been"
	einfo "merged, please read the documentation at http://www.lirc.org"
	echo
}

