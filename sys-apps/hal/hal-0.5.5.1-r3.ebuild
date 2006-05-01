# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hal/hal-0.5.5.1-r3.ebuild,v 1.13 2006/05/01 10:11:37 steev Exp $

inherit eutils linux-info debug

DESCRIPTION="Hardware Abstraction Layer"
HOMEPAGE="http://www.freedesktop.org/Software/hal"
SRC_URI="http://freedesktop.org/~david/dist/${P}.tar.gz"

LICENSE="|| ( GPL-2 AFL-2.0 )"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 ppc ppc64 sparc x86"
IUSE="acpi debug doc pam_console pcmcia selinux"

RDEPEND=">=dev-libs/glib-2.6
	>=sys-apps/dbus-0.50
	>=sys-fs/udev-071
	>=sys-apps/util-linux-2.12i
	|| ( >=sys-kernel/linux-headers-2.6 >=sys-kernel/mips-headers-2.6 )
	dev-libs/expat
	dev-libs/libusb
	sys-apps/hotplug
	pam_console? ( sys-libs/pam )
	selinux? ( sys-libs/libselinux )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.29
	doc? ( app-doc/doxygen app-text/docbook-sgml-utils )"

## HAL Daemon drops privledges so we need group access to read disks
HALDAEMON_GROUPS="haldaemon,disk,cdrom,cdrw,floppy,usb"

function notify_uevent() {
	eerror
	eerror "You must enable Kernel Userspace Events in your kernel."
	eerror "This can be set under 'General Setup'.  It is marked as"
	eerror "CONFIG_KOBJECT_UEVENT in the config file."
	eerror
	ebeep 5

	die "KOBJECT_UEVENT is not set"
}

pkg_setup() {
	linux-info_pkg_setup

	kernel_is ge 2 6 13 \
		|| die "You need a 2.6.13 or newer kernel to run this package"

	if kernel_is lt 2 6 15; then
		linux_chkconfig_present KOBJECT_UEVENT || notify_uevent
	fi

	if use acpi ; then
		linux_chkconfig_present PROC_FS \
			|| die "ACPI support requires PROC_FS support in kernel"
	fi

	if use pam_console && ! built_with_use sys-libs/pam pam_console ; then
			eerror "You need to build pam with pam_console support"
			eerror "Please remerge sys-libs/pam with USE=pam_console"
			die "pam without pam_console detected"
	fi

	if [ -d "${ROOT}"/etc/hal/device.d ]; then
		eerror "HAL 0.5.x will not run with the HAL 0.4.x series of"
		eerror "/etc/hal/device.d/ so please remove this directory"
		eerror "with rm -rf /etc/hal/device.d/ and then re-emerge."
		eerror "This is due to configuration protection of /etc/"
		die "remove /etc/hal/device.d/"
	fi
}


src_unpack() {
	unpack "${A}"
	cd "${S}"
	epatch "${FILESDIR}"/${P}-RBC.patch

	# remove pamconsole option
	use pam_console || epatch "${FILESDIR}"/${PN}-0.5.1-old_storage_policy.patch
}

src_compile() {
	econf \
		--with-doc-dir=/usr/share/doc/${PF} \
		--with-os-type=gentoo \
		--with-pid-file=/var/run/hald.pid \
		$(use_enable debug verbose-mode) \
		$(use_enable pcmcia pcmcia-support) \
		$(use_enable acpi acpi-proc) \
		$(use_enable doc docbook-docs) \
		$(use_enable doc doxygen-docs) \
		$(use_enable selinux) \
		|| die "configure failed"

# --disable-acpi-acpid when HAL handles all that acpid handles

	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die

	# We install this in a seperate package to avoid gnome-python dep
	rm "${D}"/usr/bin/hal-device-manager

	# initscript
	newinitd "${FILESDIR}"/0.5-hald.rc hald

	dodoc AUTHORS ChangeLog NEWS README

	# Script to unmount devices if they are yanked out (from upstream)
	exeinto /etc/dev.d/default
	doexe "${FILESDIR}"/hal-unmount.dev
}

pkg_preinst() {
	enewgroup haldaemon || die "Problem adding haldaemon group"
	enewuser haldaemon -1 "-1" -1 ${HALDAEMON_GROUPS} || die "Problem adding haldaemon user"
	usermod -G ${HALDAEMON_GROUPS} haldaemon
}

pkg_postinst() {
	einfo "The HAL daemon needs to be running for certain applications to"
	einfo "work. Suggested is to add the init script to your start-up"
	einfo "scripts, this should be done like this :"
	einfo "\`rc-update add hald default\`"
}
