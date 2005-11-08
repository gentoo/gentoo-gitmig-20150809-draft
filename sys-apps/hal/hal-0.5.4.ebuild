# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hal/hal-0.5.4.ebuild,v 1.5 2005/11/08 17:25:24 compnerd Exp $

inherit eutils linux-info

DESCRIPTION="Hardware Abstraction Layer"
HOMEPAGE="http://www.freedesktop.org/Software/hal"
SRC_URI="http://freedesktop.org/~david/dist/${P}.tar.gz"

LICENSE="|| ( GPL-2 AFL-2.0 )"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ia64 ~ppc ~ppc64 ~sparc"
IUSE="debug pcmcia doc pam_console"

RDEPEND=">=dev-libs/glib-2.6
	>=sys-apps/dbus-0.33
	dev-libs/expat
	>=sys-fs/udev-063
	sys-apps/hotplug
	>=sys-apps/util-linux-2.12i
	||( >=sys-kernel/linux-headers-2.6 >=sys-kernel/mips-headers-2.6 )
	dev-libs/libusb
	pam_console? ( sys-libs/pam )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.29
	doc? ( app-doc/doxygen app-text/docbook-sgml-utils )"

## HAL Daemon drops privledges so we need group access to read disks
HALDAEMON_GROUPS="haldaemon,disk,cdrom,cdrw,floppy,usb"

pkg_setup() {

	linux-info_pkg_setup
	kernel_is ge 2 6 10 \
		|| die "You need a 2.6.10 or newer kernel to run this package"

	if use pam_console && ! built_with_use sys-libs/pam pam_console ; then
			eerror "You need to build pam with pam_console support"
			eerror "Please remerge sys-libs/pam with USE=pam_console"
			die "pam without pam_console detected"
	fi

	if [ -d ${ROOT}/etc/hal/device.d ]; then
		eerror "HAL 0.5.x will not run with the HAL 0.4.x series of"
		eerror "/etc/hal/device.d/ so please remove this directory"
		eerror "with rm -rf /etc/hal/device.d/ and then re-emerge."
		eerror "This is due to configuration protection of /etc/"
		die "remove /etc/hal/device.d/"
	fi
}


src_unpack() {
	unpack ${A}
	cd ${S}
	# remove pamconsole option
	use pam_console || epatch ${FILESDIR}/${PN}-0.5.1-old_storage_policy.patch
}

src_compile() {
	econf \
		$(use_enable debug verbose-mode) \
		$(use_enable pcmcia pcmcia-support) \
		--enable-sysfs-carrier \
		--enable-hotplug-map \
		$(use_enable doc docbook-docs) \
		$(use_enable doc doxygen-docs) \
		--with-pid-file=/var/run/hald.pid \
		|| die "configure failed"

	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die

	# We install this in a seperate package to avoid gnome-python dep
	rm ${D}/usr/bin/hal-device-manager

	# initscript
	newinitd ${FILESDIR}/0.5-hald.rc hald

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README

	# Script to unmount devices if they are yanked out (from upstream)
	exeinto /etc/dev.d/default
	doexe ${FILESDIR}/hal-unmount.dev
}

pkg_postinst() {
	## We need to add the user/groups *after* package compilation/installation, so that we
	## don't change the user without the package being installed.
	##
	enewgroup haldaemon || die "Problem adding haldaemon group"
	# HAL drops priviledges by default now ...
	# ... so we must make sure it can read disk/cdrom info (ie. be in ${HALDAEMON_GROUPS} groups)
	enewuser haldaemon -1 "-1" /dev/null ${HALDAEMON_GROUPS} || die "Problem adding haldaemon user"

	# Make sure that the haldaemon user is in the ${HALDAEMON_GROUPS}
	# If users have a problem with this, let them file a bug
	usermod -G ${HALDAEMON_GROUPS} haldaemon

	einfo "The HAL daemon needs to be running for certain applications to"
	einfo "work. Suggested is to add the init script to your start-up"
	einfo "scripts, this should be done like this :"
	einfo "\`rc-update add hald default\`"
}
