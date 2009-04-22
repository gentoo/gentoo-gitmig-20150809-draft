# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pmount/pmount-0.9.19.ebuild,v 1.3 2009/04/22 22:44:07 eva Exp $

EAPI="2"

inherit base eutils

DESCRIPTION="Policy based mounter that gives the ability to mount removable devices as a user"
HOMEPAGE="http://pmount.alioth.debian.org/"
SRC_URI="http://alioth.debian.org/frs/download.php/2867/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE="crypt hal"

RDEPEND="hal? ( >=sys-apps/dbus-0.33 >=sys-apps/hal-0.5.2 )
	crypt? ( >=sys-fs/cryptsetup-1.0.5 )"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40"

# FIXME: Testsuite fails.
RESTRICT="test"

PATCHES=("${FILESDIR}/${P}-ext4-support.patch")

pkg_setup() {
	enewgroup plugdev
}

src_configure() {
	econf $(use_enable hal)
}

src_install () {
	# Must be run SETUID+SETGID, bug #250106
	exeinto /usr/bin
	exeopts -m 6710 -g plugdev
	doexe src/pmount src/pumount || die "doexe failed"

	dodoc AUTHORS ChangeLog TODO || die "dodoc failed"
	doman man/pmount.1 man/pumount.1 || die "doman failed"

	if use hal; then
		doexe src/pmount-hal || die "doexe failed"
		doman man/pmount-hal.1  || die "doman failed"
	fi

	insinto /etc
	doins etc/pmount.allow || die "doins failed"
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
