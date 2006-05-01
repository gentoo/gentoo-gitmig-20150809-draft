# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hal/hal-0.4.7-r2.ebuild,v 1.12 2006/05/01 10:11:37 steev Exp $

inherit eutils python linux-info versionator flag-o-matic

DESCRIPTION="Hardware Abstraction Layer"
HOMEPAGE="http://www.freedesktop.org/Software/hal"
SRC_URI="http://freedesktop.org/~david/dist/${P}.tar.gz"

LICENSE="|| ( GPL-2 AFL-2.0 )"
SLOT="0"
KEYWORDS="amd64 ia64 ppc ppc64 x86"
IUSE="debug pcmcia doc livecd"

RDEPEND=">=dev-libs/glib-2.4
	=sys-apps/dbus-0.23*
	dev-libs/expat
	sys-fs/udev
	sys-apps/hotplug
	sys-libs/libcap
	dev-libs/popt
	>=sys-apps/util-linux-2.12i
	>=sys-kernel/linux-headers-2.6"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.29
	doc? ( app-doc/doxygen )"
# dep on a specific util-linux version for 
# managed mount patches #70873

# We need to run at least a 2.6.10 kernel, this is a
# way to ensure that to some extent
pkg_setup() {

	use livecd && return

	if get_version; then
		kernel_is ge 2 6 10 && return
	elif get_running_version; then
		kernel_is ge 2 6 10 && return
	fi

	die "You need to run a 2.6.10 or newer kernel to build & use this pack"

}

src_unpack() {

	unpack ${A}

	cd ${S}
	# remove pamconsole option
	epatch ${FILESDIR}/${PN}-0.4.1-old_storage_policy.patch
	# pick up the gentoo usermap
	epatch ${FILESDIR}/${PN}-0.4.5-gentoo_gphoto2_usermap.patch
	# don't doubleadd devices
	epatch ${FILESDIR}/${P}-dont_add_device_twice-r1.patch
	# fix memleaks
	cd ${S}/hald
	epatch ${FILESDIR}/${P}-device_info_leak.patch
	# detect floppy drives on >=2.6.12 kernels as well
	epatch ${FILESDIR}/${P}-sys_floppy_detection.patch
	# set defaultpolicy for vfat from iocharset=utf8 to utf8 (#83025)
	cd ${S}
	epatch ${FILESDIR}/${P}-vfat_mount_utf8.patch

}

src_compile() {

	# FIXME : docs
	econf \
		`use_enable debug verbose-mode` \
		`use_enable pcmcia pcmcia-support` \
		--enable-sysfs-carrier \
		--enable-fstab-sync \
		--enable-hotplug-map \
		--disable-docbook-docs \
		`use_enable doc doxygen-docs` \
		--with-pid-file=/var/run/hald/hald.pid \
		|| die

	emake || die

}

src_install() {

	make DESTDIR=${D} install || die

	# We install this in a seperate package to avoid gnome-python dep
	rm ${D}/usr/bin/hal-device-manager

	# initscript
	exeinto /etc/init.d/
	doexe ${FILESDIR}/hald

	# place our pid file
	keepdir /var/run/hald

	# keep the policy setup intact
	keepdir /usr/share/hal/fdi/{95userpolicy,50user,40oem,30osvendor,10generic}

	dodoc AUTHORS ChangeLog NEWS README

}

pkg_preinst() {

	enewgroup haldaemon || die "Problem adding haldaemon group"
	enewuser haldaemon -1 -1 /dev/null haldaemon || die "Problem adding haldaemon user"

}

pkg_postinst() {

	# make sure the permissions on the pid dir are alright & after preinst
	chown haldaemon:haldaemon /var/run/hald

	ewarn "Enabled in this ebuild by default is the usage of fstab-sync"
	ewarn "that will create mount rules for non-existing devices in"
	ewarn "fstab if needed, mount points will be created in /media."
	ewarn "This functionality alters /etc/fstab runtime on the filesystem"
	ewarn "and should be considered a security risk."
	echo
	einfo "The HAL daemon needs to be running for certain applications to"
	einfo "work. Suggested is to add the init script to your start-up"
	einfo "scripts, this should be done like this :"
	einfo "\`rc-update add hald default\`"

}
