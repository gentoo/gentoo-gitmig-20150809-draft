# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hal/hal-0.2.97.ebuild,v 1.1 2004/08/17 21:01:52 foser Exp $

inherit eutils debug python

DESCRIPTION="Hardware Abstraction Layer"
HOMEPAGE="http://www.freedesktop.org/Software/hal"

SRC_URI="http://freedesktop.org/~david/dist/${P}.tar.gz"
LICENSE="GPL-2 | AFL-2.0"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.2.2
	>=sys-apps/dbus-0.22
	dev-libs/expat
	sys-fs/udev
	sys-apps/hotplug"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {

	# FIXME : docs
	econf \
		--disable-doxygen-docs \
		--disable-docbook-docs \
		|| die

	emake || die

}

src_install() {

	make DESTDIR=${D} install || die

	# initscript
	exeinto /etc/init.d/
	doexe ${FILESDIR}/hald

	# fstab automatic device creation
	dosym /usr/sbin/fstab-sync /etc/hal/device.d/fstab-sync

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README

}

pkg_preinst() {

	enewgroup haldaemon || die "Problem adding haldaemon group"
	enewuser haldaemon -1 /bin/false /dev/null haldaemon || die "Problem adding haldaemon user"

}

pkg_postinst() {

	einfo "Enabled in this ebuild by default is the usage of fstab-sync"
	einfo "that will create mount rules for non-existing devices in"
	einfo "fstab if needed, mount points will be created in /media."
	einfo "This functionality alters your fstab runtime on the filesystem"
	einfo "and might affects certain applications."

}
