# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/uam/uam-0.0.7.ebuild,v 1.2 2010/10/13 20:27:30 maekke Exp $

inherit eutils multilib

DESCRIPTION="Simple udev-based automounter for removable USB media"
HOMEPAGE="http://github.com/mgorny/uam/"
SRC_URI="http://github.com/downloads/mgorny/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-fs/udev"

src_compile() {
	emake LIBDIR=/$(get_libdir) || die
}

src_install() {
	emake LIBDIR=/$(get_libdir) DESTDIR="${D}" install || die

	dodoc NEWS README || die
}

pkg_postinst() {
	# The plugdev group is created by pam, pmount and many other ebuilds
	# in gx86. As we don't want to depend on any of them (even pmount is
	# optional), we create it ourself too.
	enewgroup plugdev

	elog "To be able to access uam-mounted filesystems, you have to be"
	elog "a member of the 'plugdev' group."
	elog
	elog "Note that uam doesn't provide any way to allow unprivileged user"
	elog "to manually umount devices. The upstream suggested solution"
	elog "is to use [sys-apps/pmount]. If you don't feel like installing"
	elog "additional tools, remember to sync before removing your USB stick."
	elog
	elog "Another feature uam is not capable of is mounting removable media"
	elog "in fixed drives, like CDs and floppies. You might, however, be able"
	elog "to mount them as an unprivileged user using appropriate fstab entries"
	elog "or [sys-apps/pmount]."
	elog
	elog "If you'd like to receive libnotify-based notifications, you need"
	elog "to install the [x11-misc/sw-notify-send] tool from the Sunrise"
	elog "overlay [1] (or bug #318961 [2])."
	elog
	elog "[1] http://overlays.gentoo.org/proj/sunrise"
	elog "[2] http://bugs.gentoo.org/show_bug.cgi?id=318961"

	if [[ -e "${ROOT}"/dev/.udev ]]; then
		ebegin "Calling udev to reload its rules"
		udevadm control --reload-rules
		eend $?
	fi
}
