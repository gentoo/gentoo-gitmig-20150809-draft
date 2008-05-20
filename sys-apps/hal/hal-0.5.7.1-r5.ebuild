# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hal/hal-0.5.7.1-r5.ebuild,v 1.20 2008/05/20 04:30:38 compnerd Exp $

inherit eutils linux-info

DESCRIPTION="Hardware Abstraction Layer"
HOMEPAGE="http://www.freedesktop.org/Software/hal"
SRC_URI="http://freedesktop.org/~david/dist/${P}.tar.gz"

LICENSE="|| ( GPL-2 AFL-2.0 )"
SLOT="0"
KEYWORDS="alpha ~amd64 arm hppa ia64 ~ppc ppc64 sh sparc x86"
IUSE="acpi crypt debug dmi doc pcmcia selinux"

RDEPEND=">=dev-libs/glib-2.6
	>=dev-libs/dbus-glib-0.71
	>=sys-fs/udev-083
	>=sys-apps/util-linux-2.12r
	|| ( >=sys-kernel/linux-headers-2.6 >=sys-kernel/mips-headers-2.6 )
	dev-libs/expat
	sys-apps/pciutils
	dev-libs/libusb
	virtual/eject
	dmi? ( >=sys-apps/dmidecode-2.7 )
	crypt? ( >=sys-fs/cryptsetup-1.0.5 )
	selinux? ( sys-libs/libselinux )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.29
	doc? ( app-doc/doxygen app-text/docbook-sgml-utils )"

## HAL Daemon drops privledges so we need group access to read disks
HALDAEMON_GROUPS="haldaemon,plugdev,disk,cdrom,cdrw,floppy,usb"

function check_uevent() {
	local CONFIG_CHECK="~KOBJECT_UEVENT"
	local WARNING_KOBJECT_UEVENT="CONFIG_KOBJECT_UEVENT:\tis not set (required for HAL)
"
	check_extra_config
}

function check_hotplug_net() {
	local CONFIG_CHECK="~HOTPLUG ~NET"
	local WARNING_HOTPLUG="CONFIG_HOTPLUG:\tis not set (required for HAL)
"
	local WARNING_NET="CONFIG_NET:\tis not set (required for HAL)
"
	check_extra_config
}

function check_procfs() {
	local CONFIG_CHECK="~PROC_FS"
	local WARNING_PROC_FS="CONFIG_PROC_FS:\tis not set (required for HAL)
"
	check_extra_config
}

pkg_setup() {
	if ! built_with_use --missing true sys-apps/pciutils hal ; then
		if built_with_use --missing false sys-apps/pciutils zlib ; then
			die "You MUST build sys-apps/pciutils without the zlib USE flag"
		fi
	fi

	if [ -e "${ROOT}/usr/src/linux/.config" ] ; then
		if kernel_is ge 2 6 16 ; then
			check_hotplug_net
		elif kernel_is eq 2 6 15 ; then
			check_uevent
		else
			ewarn "HAL requires a kernel version 2.6.15 or newer"
		fi
	fi

	use acpi && check_procfs

	if [ -d "${ROOT}/etc/hal/device.d" ]; then
		eerror "HAL 0.5.x will not run with the HAL 0.4.x series of"
		eerror "/etc/hal/device.d/ so please remove this directory"
		eerror "with rm -rf /etc/hal/device.d/ and then re-emerge."
		eerror "This is due to configuration protection of /etc/"
		die "remove /etc/hal/device.d/"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# handle ignored volumes properly
	epatch "${FILESDIR}"/${PN}-0.5.7.1-ignored-volumes.patch

	# Fix bash in hald scripts
	epatch "${FILESDIR}"/${PN}-0.5.7.1-hald-scripts.patch

	# probe partition table
	epatch "${FILESDIR}"/${PN}-0.5.7-part-table.patch

	# fix pmu support crash
	epatch "${FILESDIR}"/${PN}-0.5.7-pmu-fix.patch

	# unclean unmount
	epatch "${FILESDIR}"/${PN}-0.5.7-unclean-unmount-r1.patch

	# allow plugdev group people to mount
	epatch "${FILESDIR}"/${PN}-0.5.7-plugdev-allow-send.patch

	# rescan devices on resume
	epatch "${FILESDIR}"/${PN}-0.5.7.1-rescan-on-resume.patch

	# dbus deprecated dbus_connection_disconnect
	epatch "${FILESDIR}"/${PN}-0.5.7.1-dbus-close.patch

	# sr driver fix
	epatch "${FILESDIR}"/${PN}-0.5.7.1-sr-driver.patch

	# mounting autofs & subfs fixes
	epatch "${FILESDIR}"/${PN}-0.5.7.1-autofs-subfs.patch

	# iPod Nano detected as RAID fix
	epatch "${FILESDIR}"/${PN}-0.5.7.1-ipod-nano.patch

	# Floppies mounting fix
	epatch "${FILESDIR}"/${PN}-0.5.7.1-floppies-fix.patch

	# fix undeclared ctype.h so everyone can stop getting their panties in a
	# bundle
	epatch "${FILESDIR}"/${PN}-0.5.7.1-ctype-fix.patch

	# fix for dbus close/unref so we stop having errors from lshal about D-Bus
	epatch "${FILESDIR}"/${PN}-0.5.7.1-fix-dbus.patch

	# Fix for fdi issues with indirection problem in copy_property
	# All work by Martin "Parmus" Parm <parmus@diku.dk
	# passed upstream as fd.o bug #9849
	epatch "${FILESDIR}"/${PN}-0.5.7.1-indirection-fix.patch
}

src_compile() {

	econf \
		--with-doc-dir=/usr/share/doc/${PF} \
		--with-os-type=gentoo \
		--with-pid-file=/var/run/hald.pid \
		--with-hwdata=/usr/share/misc \
		--enable-hotplug-map \
		$(use_enable debug verbose-mode) \
		$(use_enable pcmcia pcmcia-support) \
		$(use_enable acpi acpi-proc) \
		$(use_enable doc docbook-docs) \
		$(use_enable doc doxygen-docs) \
		$(use_enable selinux) \
		|| die "configure failed"

	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README

	# remove dep on gnome-python
	mv "${D}"/usr/bin/hal-device-manager "${D}"/usr/share/hal/device-manager/

	# hal umount for unclean unmounts
	exeinto /lib/udev/
	newexe "${FILESDIR}"/hal-unmount.dev hal_unmount

	# initscript
	newinitd "${FILESDIR}"/0.5-hald.rc hald

	# We now create and keep /media here as both gnome-mount and pmount
	# use these directories, to avoid collision.
	dodir /media
	keepdir /media
}

pkg_postinst() {
	# Despite what people keep changing this location. Either one works.. it doesn't matter
	# http://dev.gentoo.org/~plasmaroo/devmanual/ebuild-writing/functions/

	# Create groups for hotplugging and HAL
	enewgroup haldaemon || die "Problem adding haldaemon group"
	enewgroup plugdev || die "Problem adding plugdev group"

	# HAL drops priviledges by default now ...
	# ... so we must make sure it can read disk/cdrom info (ie. be in ${HALDAEMON_GROUPS} groups)
	enewuser haldaemon -1 "-1" /dev/null ${HALDAEMON_GROUPS} || die "Problem adding haldaemon user"

	# Make sure that the haldaemon user is in the ${HALDAEMON_GROUPS}
	# If users have a problem with this, let them file a bug
	usermod -G ${HALDAEMON_GROUPS} haldaemon

	elog "The HAL daemon needs to be running for certain applications to"
	elog "work. Suggested is to add the init script to your start-up"
	elog "scripts, this should be done like this :"
	elog "\`rc-update add hald default\`"
	echo
	elog "Looking for automounting support? Add yourself to the plugdev group"
}
