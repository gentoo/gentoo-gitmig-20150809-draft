# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/udev/udev-104-r11.ebuild,v 1.12 2007/03/27 20:44:50 zzam Exp $

inherit eutils flag-o-matic multilib toolchain-funcs

DESCRIPTION="Linux dynamic and persistent device naming support (aka userspace devfs)"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/kernel/hotplug/udev.html"
SRC_URI="mirror://kernel/linux/utils/kernel/hotplug/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
IUSE="selinux"

DEPEND="selinux? ( sys-libs/libselinux )"
RDEPEND="!sys-apps/coldplug"
RDEPEND="${DEPEND} ${RDEPEND}
	>=sys-apps/baselayout-1.12.5"
# We need the lib/rcscripts/addon support
PROVIDE="virtual/dev-manager"

src_unpack() {
	unpack ${A}

	cd "${S}"

	# patches go here...
	#epatch ${FILESDIR}/${P}-udev_volume_id.patch
	epatch ${FILESDIR}/${P}-netif-rename-busywait.patch
	epatch ${FILESDIR}/${PN}-104-peristent-net-disable-xen.patch
	epatch ${FILESDIR}/${PN}-104-persistent-net-fix-name-dups.patch
	epatch ${FILESDIR}/${PN}-105-vol_id-fix.patch
	epatch ${FILESDIR}/${PN}-105-unlink-db-files.patch

	# No need to clutter the logs ...
	sed -ie '/^DEBUG/ c\DEBUG = false' Makefile
	# Do not use optimization flags from the package
	sed -ie 's|$(OPTIMIZATION)||g' Makefile

	# Make sure there is no sudden changes to udev.rules.gentoo
	# (more for my own needs than anything else ...)
	MD5=`md5sum < "${S}/etc/udev/gentoo/udev.rules"`
	MD5=${MD5/  -/}
	if [ "${MD5}" != "295a9b7bdc8bdb239f8860d14af761b0" ]
	then
		echo
		eerror "gentoo/udev.rules has been updated, please validate!"
		die "gentoo/udev.rules has been updated, please validate!"
	fi
}

src_compile() {
	filter-flags -fprefetch-loop-arrays
	local myconf=
	local extras="extras/ata_id \
				  extras/cdrom_id \
				  extras/dasd_id \
				  extras/edd_id \
				  extras/firmware \
				  extras/floppy \
				  extras/path_id \
				  extras/run_directory \
				  extras/scsi_id \
				  extras/usb_id \
				  extras/volume_id \
				  extras/rule_generator"

	use selinux && myconf="${myconf} USE_SELINUX=true"

	# Not everyone has full $CHOST-{ld,ar,etc...} yet
	local mycross=""
	type -p ${CHOST}-ar && mycross=${CHOST}-

	echo "get_libdir = $(get_libdir)"
	# Do not work with emake
	make \
		EXTRAS="${extras}" \
		udevdir="/dev/" \
		CROSS_COMPILE=${mycross} \
		${myconf} || die
}

src_install() {
	# we install everything by "hand" and don't rely on the udev Makefile to do
	# it for us (why? it's easier that way...)
	dobin udevinfo		|| die "Required binary not installed properly"
	dobin udevtest		|| die "Required binary not installed properly"
	dobin udevmonitor	|| die "Required binary not installed properly"
	into /
	dosbin udevd		|| die "Required binary not installed properly"
	dosbin udevstart	|| die "Required binary not installed properly"
	dosbin udevtrigger	|| die "Required binary not installed properly"
	dosbin udevcontrol	|| die "Required binary not installed properly"
	dosbin udevsettle	|| die "Required binary not installed properly"

	# Helpers
	exeinto /lib/udev
	doexe extras/run_directory/udev_run_devd	|| die "Required helper not installed properly"
	doexe extras/run_directory/udev_run_hotplugd	|| die "Required helper not installed properly"
	doexe extras/ata_id/ata_id		|| die "Required helper not installed properly"
	doexe extras/volume_id/vol_id	|| die "Required helper not installed properly"
	doexe extras/scsi_id/scsi_id	|| die "Required helper not installed properly"
	doexe extras/usb_id/usb_id		|| die "Required helper not installed properly"
	doexe extras/path_id/path_id	|| die "Required helper not installed properly"
	doexe extras/cdrom_id/cdrom_id	|| die "Required helper not installed properly"
	doexe extras/dasd_id/dasd_id	|| die "Required helper not installed properly"
	doexe extras/edd_id/edd_id		|| die "Required helper not installed properly"
	doexe extras/rule_generator/write_cd_rules	|| die "Required helper not installed properly"
	doexe extras/rule_generator/write_net_rules	|| die "Required helper not installed properly"
	doexe extras/rule_generator/rule_generator.functions	|| die "Required helper not installed properly"
	keepdir /lib/udev/state
	keepdir /lib/udev/devices

	# vol_id library (needed by mount and HAL)
	dolib extras/volume_id/lib/*.a extras/volume_id/lib/*.so*
	# move the .a files to /usr/lib
	dodir /usr/$(get_libdir)
	mv -f "${D}"/$(get_libdir)/*.a  "${D}"/usr/$(get_libdir)/

	# handle static linking bug #4411
	gen_usr_ldscript libvolume_id.so

	# save pkgconfig info
	insinto /usr/$(get_libdir)/pkgconfig
	doins extras/volume_id/lib/*.pc

	#exeinto /etc/udev/scripts
	exeinto /lib/udev
	#doexe extras/ide-devfs.sh
	#doexe extras/scsi-devfs.sh
	#doexe extras/raid-devfs.sh
	doexe extras/floppy/create_floppy_devices	|| die "Required binary not installed properly"
	doexe extras/firmware/firmware.sh			|| die "Required binary not installed properly"
	newexe ${FILESDIR}/net-104-r10.sh net.sh	|| die "Required binary not installed properly"
	doexe ${FILESDIR}/modprobe.sh				|| die "Required binary not installed properly"
	doexe ${FILESDIR}/seq_node.sh				|| die "Required binary not installed properly"

	# Our udev config file
	insinto /etc/udev
	newins ${FILESDIR}/udev.conf.post_081 udev.conf

	# Our rules files
	insinto /etc/udev/rules.d/
	newins etc/udev/gentoo/udev.rules 50-udev.rules
	newins ${FILESDIR}/udev.rules-104-r10 50-udev.rules
	newins ${FILESDIR}/05-udev-early.rules-104-r5 05-udev-early.rules
	doins ${FILESDIR}/95-net.rules
	# Use upstream's persistent rules for devices
	doins etc/udev/rules.d/60-*.rules
	doins extras/rule_generator/75-*.rules || die "rules not installed properly"

	# scsi_id configuration
	insinto /etc
	doins extras/scsi_id/scsi_id.config

	# set up the /etc/dev.d directory tree
	keepdir /etc/dev.d

	# all of the man pages
	doman *.7
	doman *.8
	doman extras/ata_id/ata_id.8
	doman extras/edd_id/edd_id.8
	doman extras/scsi_id/scsi_id.8
	doman extras/volume_id/vol_id.8
	doman extras/dasd_id/dasd_id.8
	doman extras/cdrom_id/cdrom_id.8
	# create a extra symlink for udevcontrol
	dosym udevd.8 /usr/share/man/man8/udevcontrol.8

	# our udev hooks into the rc system
	insinto /$(get_libdir)/rcscripts/addons
	newins "${FILESDIR}"/udev-start-104-r10.sh udev-start.sh
	newins "${FILESDIR}"/udev-stop-104-r8.sh udev-stop.sh

	# Insert udev-version number into udev-rcscript addon
	sed -e "s/@@UDEV_VERSION@@/${PV}/" \
		-i "${D}"/$(get_libdir)/rcscripts/addons/udev-start.sh \
		-i "${D}"/$(get_libdir)/rcscripts/addons/udev-stop.sh

	# needed to compile latest Hal
	insinto /usr/include
	doins extras/volume_id/lib/libvolume_id.h

	dodoc ChangeLog FAQ README TODO RELEASE-NOTES
	dodoc docs/{overview,udev_vs_devfs}
	dodoc docs/writing_udev_rules/*

	newdoc extras/volume_id/README README_volume_id

}

pkg_preinst() {
	if [[ -d ${ROOT}/lib/udev-state ]] ; then
		mv -f "${ROOT}"/lib/udev-state/* "${D}"/lib/udev/state/
		rm -r "${ROOT}"/lib/udev-state
	fi

	if [ -f "${ROOT}/etc/udev/udev.config" -a \
	     ! -f "${ROOT}/etc/udev/udev.rules" ]
	then
		mv -f ${ROOT}/etc/udev/udev.config ${ROOT}/etc/udev/udev.rules
	fi

	# delete the old udev.hotplug symlink if it is present
	if [ -h "${ROOT}/etc/hotplug.d/default/udev.hotplug" ]
	then
		rm -f ${ROOT}/etc/hotplug.d/default/udev.hotplug
	fi

	# delete the old wait_for_sysfs.hotplug symlink if it is present
	if [ -h "${ROOT}/etc/hotplug.d/default/05-wait_for_sysfs.hotplug" ]
	then
		rm -f ${ROOT}/etc/hotplug.d/default/05-wait_for_sysfs.hotplug
	fi

	# delete the old wait_for_sysfs.hotplug symlink if it is present
	if [ -h "${ROOT}/etc/hotplug.d/default/10-udev.hotplug" ]
	then
		rm -f ${ROOT}/etc/hotplug.d/default/10-udev.hotplug
	fi

	# is there a stale coldplug initscript? (CONFIG_PROTECT leaves it behind)
	coldplug_stale=""
	if [ -f "${ROOT}/etc/init.d/coldplug" ]
	then
		coldplug_stale="1"
	fi
}

pkg_postinst() {
	if [[ ${ROOT} == "/" ]] ; then
		if [[ -n $(pidof udevd) ]] ; then
			killall -15 udevd &>/dev/null
			sleep 1
			killall -9 udevd &>/dev/null
		fi
		/sbin/udevd --daemon
	fi

	# people want reminders, I'll give them reminders.  Odds are they will
	# just ignore them anyway...

	if [[ ${coldplug_stale} == "1" ]] ; then
		ewarn "A stale coldplug init script found. You should run:"
		ewarn
		ewarn "      rc-update del coldplug"
		ewarn "      rm -f /etc/init.d/coldplug"
		ewarn
		ewarn "udev now provides its own coldplug functionality."
	fi

	# delete 40-scsi-hotplug.rules - all integrated in 50-udev.rules
	if has_version "=sys-fs/udev-103-r3"; then
		if [[ -e "${ROOT}/etc/udev/rules.d/40-scsi-hotplug.rules" ]]
		then
			ewarn "Deleting stray 40-scsi-hotplug.rules"
			ewarn "installed by sys-fs/udev-103-r3"
			rm -f ${ROOT}/etc/udev/rules.d/40-scsi-hotplug.rules
		fi
	fi

	# Removing some device-nodes we thought we need some time ago
	if [[ -d "${ROOT}"/lib/udev/devices ]]; then
		rm -f "${ROOT}"/lib/udev/devices/{null,zero,console,urandom}
	fi

	# Removing some old file
	if has_version "<sys-fs/udev-104-r5"; then
		rm -f "${ROOT}"/etc/dev.d/net/hotplug.dev
		rmdir --ignore-fail-on-non-empty "${ROOT}"/etc/dev.d/net
	fi

	einfo
	einfo "For more information on udev on Gentoo, writing udev rules, and"
	einfo "         fixing known issues visit:"
	einfo "         http://www.gentoo.org/doc/en/udev-guide.xml"
}
