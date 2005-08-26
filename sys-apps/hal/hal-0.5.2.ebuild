# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hal/hal-0.5.2.ebuild,v 1.2 2005/08/26 05:40:23 cardoe Exp $

inherit eutils linux-info versionator flag-o-matic

DESCRIPTION="Hardware Abstraction Layer"
HOMEPAGE="http://www.freedesktop.org/Software/hal"
SRC_URI="http://freedesktop.org/~david/dist/${P}.tar.gz"

LICENSE="|| ( GPL-2 AFL-2.0 )"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ia64 ~ppc ~ppc64"
IUSE="debug pcmcia doc pam_console"


### We don't technically "need" pam, but without pam_console, stuff 
### doesn't work (particularly NetworkManager).
### dep on a specific util-linux version for managed mount patches #70873
RDEPEND=">=dev-libs/glib-2.6
	>=sys-apps/dbus-0.33
	dev-libs/expat
	>=sys-fs/udev-063
	sys-apps/hotplug
	>=sys-apps/util-linux-2.12i
	>=sys-kernel/linux-headers-2.6
	dev-libs/libusb
	pam_console? ( sys-libs/pam )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.29
	doc? ( app-doc/doxygen )"

## HAL Daemon drops privledges so we need group access to read disks
HALDAEMON_GROUPS="haldaemon,disk,cdrom,cdrw,floppy"

# We need to run at least a 2.6.10 kernel, this is a
# way to ensure that to some extent
pkg_setup() {

	linux-info_pkg_setup
	kernel_is ge 2 6 10 \
		|| die "You need a 2.6.10 or newer kernel to run this package"

	if use pam_console && ! built_with_use sys-libs/pam pam_console ; then
			eerror "You need to build pam with pam_console support"
			eerror "Please remerge sys-libs/pam with USE=pam_console"
			die "pam without pam_console detected"
	fi

	if [ -d ${D}/etc/hal/device.d ]; then
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
	epatch ${FILESDIR}/hal-udev-63.patch
	# remove pamconsole option
	use pam_console || epatch ${FILESDIR}/${PN}-0.5.1-old_storage_policy.patch
}

src_compile() {

	local myconf

	# NOTE: fstab-sync dies at an assert() and is deprecated upstream.
	# As such, no need to support it.  
	econf \
		`use_enable debug verbose-mode` \
		`use_enable pcmcia pcmcia-support` \
		--enable-sysfs-carrier \
		--enable-hotplug-map \
		`use_enable doc docbook-docs` \
		`use_enable doc doxygen-docs` \
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
	##
	## The old hal ran as root.  This was *very* bad because of all the user IO that HAL does.
	## The new hal runs as 'haldaemon', but haldaemon needs to be in the appropriate groups to work.
	## Below is a hack to make this transition (upgrade from previous versions) smooth.
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
