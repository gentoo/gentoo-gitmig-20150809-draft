# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hal/hal-0.4.0.ebuild,v 1.1 2004/10/28 22:22:37 foser Exp $

inherit eutils debug python

DESCRIPTION="Hardware Abstraction Layer"
HOMEPAGE="http://www.freedesktop.org/Software/hal"

SRC_URI="http://freedesktop.org/~david/dist/${P}.tar.gz"
LICENSE="|| ( GPL-2 AFL-2.0 )"

SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

RDEPEND=">=dev-libs/glib-2.2.2
	>=sys-apps/dbus-0.22-r1
	dev-libs/expat
	sys-fs/udev
	sys-apps/hotplug
	sys-libs/libcap
	sys-kernel/linux26-headers"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {

	unpack ${A}

	cd ${S}
	# remove RH only stuff
	epatch ${FILESDIR}/${P}-old_storage_policy.patch
	# fix floppy drives be shown
	epatch ${FILESDIR}/${P}-allow-floppy-drives.patch
	# fix default drivenames fallback & other RH goodies
	epatch ${FILESDIR}/${P}-storage-policy-never-use-uuid.patch
	epatch ${FILESDIR}/${P}-clean-on-startup.patch
	epatch ${FILESDIR}/${P}-fix-fstab-sync-crasher.patch

}

src_compile() {

	# FIXME : docs
	econf \
		--enable-fstab-sync \
		--enable-hotplug-map \
		--disable-doxygen-docs \
		--disable-docbook-docs \
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

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README

}

pkg_preinst() {

	enewgroup haldaemon || die "Problem adding haldaemon group"
	enewuser haldaemon -1 /bin/false /dev/null haldaemon || die "Problem adding haldaemon user"

}

pkg_postinst() {

	# make sure the permissions on the pid dir are alright & after preinst
	chown haldaemon:haldaemon /var/run/hald

	ewarn "Enabled in this ebuild by default is the usage of fstab-sync"
	ewarn "that will create mount rules for non-existing devices in"
	ewarn "fstab if needed, mount points will be created in /media."
	ewarn "This functionality alters /etc/fstab runtime on the filesystem"
	ewarn "and might have unforseen side-effects."
	echo
	einfo "The HAL daemon needs to be running for certain applications to"
	einfo "work. Suggested is to add the init script to your start-up"
	einfo "scripts, this should be done like this :"
	einfo "\`rc-update add hald default\`"

}
