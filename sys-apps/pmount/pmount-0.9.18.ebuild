# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pmount/pmount-0.9.18.ebuild,v 1.1 2009/02/01 01:09:23 eva Exp $

inherit eutils

DESCRIPTION="Policy based mounter that gives the ability to mount removable devices as a user"
HOMEPAGE="http://pmount.alioth.debian.org/"
SRC_URI="http://alioth.debian.org/frs/download.php/2624/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE="crypt hal"

RDEPEND="hal? ( >=sys-apps/dbus-0.33 >=sys-apps/hal-0.5.2 )
	>=sys-fs/sysfsutils-1.3.0
	crypt? ( >=sys-fs/cryptsetup-1.0.5 )"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40"

# Newly introduced test suite fails.
RESTRICT="test"

pkg_setup() {
	enewgroup plugdev
}

src_compile() {
	econf $(use_enable hal)
	emake || die "emake failed"
}

src_install () {
	# this is where we mount stuff
	# moved to hal as of 0.5.7-r1
	#keepdir /media

	# Must be run SETUID+SETGID, bug #250106
	exeinto /usr/bin
	exeopts -m 6710 -g plugdev
	doexe src/pmount src/pumount src/pmount-hal

	dodoc AUTHORS ChangeLog TODO
	doman man/pmount.1 man/pumount.1 man/pmount-hal.1

	insinto /etc
	doins etc/pmount.allow
}

pkg_postinst() {
	elog
	elog "This package has been installed setuid and setgid."

	elog "The permissions are as such that only users that belong to the plugdev"
	elog "group are allowed to run this. But if a script run by root mounts a"
	elog "device, members of the plugdev group will have access to it."
	elog
	elog "Please add your user to the plugdev group to be able to mount USB drives"
}
