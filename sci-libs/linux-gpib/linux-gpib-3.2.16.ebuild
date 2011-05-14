# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/linux-gpib/linux-gpib-3.2.16.ebuild,v 1.1 2011/05/14 17:05:08 dilfridge Exp $

EAPI=4

inherit base linux-mod autotools

DESCRIPTION="Kernel module and driver library for GPIB (IEEE 488.2) hardware"
HOMEPAGE="http://linux-gpib.sourceforge.net/"
SRC_URI="mirror://sourceforge/linux-gpib/${P}.tar.gz
	firmware? ( http://linux-gpib.sourceforge.net/firmware/gpib_firmware-2006-11-12.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pcmcia static debug guile perl php python tcl doc firmware"

RDEPEND="
	tcl? ( dev-lang/tcl )
	guile? ( dev-scheme/guile )
	perl? ( dev-lang/perl )
	php? ( dev-lang/php )
	python? ( dev-lang/python )
	firmware? ( sys-apps/fxload )
"

DEPEND="${RDEPEND}
	sys-kernel/module-rebuild
	doc? ( app-text/docbook-sgml-utils )
"

PATCHES=( "${FILESDIR}/${PN}-3.2.15-build.patch" )

pkg_setup () {
	linux-mod_pkg_setup

	case ${KV_MINOR} in
		4) die "This version of Linux-GPIB requires a version 2.6.x of the Linux kernel. 2.4.x kernels are supported by Linux-GPIB versions 3.1.x." ;;
		6) ;;
		*) die "Unsupported kernel version '${KV_FULL}'." ;;
	esac

	if [ ${KV_PATCH} -lt 8 ] ; then
		die "Kernel versions older than 2.6.8 are not supported."
	fi
}

src_prepare () {
	base_src_prepare
	eautoreconf
}

src_configure() {
	set_arch_to_kernel
	econf \
		$(use_enable pcmcia) \
		$(use_enable static) \
		$(use_enable debug driver-debug) \
		$(use_enable guile guile-binding) \
		$(use_enable perl perl-binding) \
		$(use_enable php php-binding) \
		$(use_enable python python-binding) \
		$(use_enable tcl tcl-binding) \
		$(use_enable doc documentation) \
		--with-linux-srcdir=${KV_DIR} \
		|| die
}

src_install () {
	set_arch_to_kernel

	FIRM_DIR=/usr/share/usb

	# Here I changed the sbindir in order to install the gpib_config to /sbin,
	# not /usr/sbin. This is done to enable running gpib_config from
	# the modprobe.conf file: if /usr is not in the root file system,
	# but a mounted partition then gpib_congig cannot be found in the moment when
	# modprobe is run.
	make \
		DESTDIR=${D} \
		INSTALL_MOD_PATH=${D} \
		HOTPLUG_USB_CONF_DIR=${D}/etc/hotplug/usb \
		USB_FIRMWARE_DIR=${D}${FIRM_DIR} \
		docdir=/usr/share/doc/${PF}/html \
		install || die "install problem"

	echo "KERNEL==\"gpib[0-9]*\",	MODE=\"0660\", GROUP=\"gpib\"" >> 99-gpib.rules
	insinto /etc/udev/rules.d/
	doins 99-gpib.rules

	dodoc doc/linux-gpib.pdf ChangeLog AUTHORS README* NEWS

	insinto /etc
	newins util/templates/gpib.conf gpib.conf
	newins util/templates/gpib.conf gpib.conf.example

	if use pcmcia ; then
		dodir /etc/pcmcia
		insinto /etc/pcmcia
		doins "${S}"/etc/pcmcia/*
	fi

	if use firmware ; then

		insinto "${FIRM_DIR}/agilent_8237a"
		doins "${WORKDIR}"/gpib_firmware-2006-11-12/agilent_8237a/*

		insinto "${FIRM_DIR}/ni_gpib_usb_b"
		doins "${WORKDIR}"/gpib_firmware-2006-11-12/ni_gpib_usb_b/*

		insinto "/usr/share/linux-gpib/hp_82341"
		doins "${WORKDIR}"/gpib_firmware-2006-11-12/hp_82341/*

	fi
}

pkg_preinst () {
	linux-mod_pkg_preinst
	enewgroup gpib
}

pkg_postinst () {
	linux-mod_pkg_postinst

	einfo "You need to run the 'gpib_config' utility to setup the driver before"
	einfo "you can use it. In order to do it automatically you can add to your"
	einfo "start script something like this (supposing the appropriate driver"
	einfo "is loaded on the startup):"
	einfo "		gpib_config --minor 0"
	einfo ""
	einfo "To give a user access to the computer's gpib board you will have to add"
	einfo "them to the group 'gpib' or, you could change the permissions on the device"
	einfo "files /dev/gpib[0-15] to something you like better, using 'chmod'."
	einfo ""
	einfo "Edit /etc/gpib.conf to match your interface board, and any devices you wish"
	einfo "to open via ibfind().  See the documentation in /usr/share/linux-gpib/html for"
	einfo "more information."
	einfo ""

	if use pcmcia ; then
		einfo "For PCMCIA cards:"
		einfo "All files needed for a PCMCIA board were copied to /etc/pcmcia."
		einfo "You may wish to edit the options passed to the gpib_config call in the"
		einfo "/etc/pcmcia/linux-gpib-pcmcia script."
		einfo "You may need to send a SIGHUP signal to the cardmgr daemon to force it"
		einfo "to reload the files in /etc/pcmcia (alternatively you could use your"
		einfo "pcmcia init.d script to restart the cardmgr, or you could just reboot)."
		einfo "The driver module will be loaded as needed by the cardmgr."
		einfo ""
	fi

	if use firmware ; then
		einfo "For Agilent (HP) 82341C and 82341D cards:"
		einfo "The firmware for these boards is uploaded by passing the appropriate"
		einfo "firmware file from /usr/share/linux-gpib/hp_82341 directory to"
		einfo "gpib_config using the -I or --init-data command line option. Example:"
		einfo "gpib_config --minor 0 --init-data \\"
		einfo "/usr/share/linux-gpib/hp_82341/hp_82341c_fw.bin"
		einfo ""
	fi

}
