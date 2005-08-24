# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pmount/pmount-0.9.3.ebuild,v 1.1 2005/08/24 06:22:11 cardoe Exp $

inherit eutils

DESCRIPTION="Mount removable devices as a normal user"
SRC_URI="http://www.piware.de/projects/${P}.tar.gz"
HOMEPAGE="http://www.piware.de/projects.shtml"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE="crypt"

RDEPEND=">=sys-apps/dbus-0.33
	>=sys-apps/hal-0.5.1
	>=sys-fs/sysfsutils-1.0
	crypt? ( sys-fs/cryptsetup )"

DEPEND=${RDEPEND}

DOCS="AUTHORS CHANGES"

pkg_setup() {
	enewgroup plugdev || die "Error creating plugdev group"
}

src_install () {
	dobin pmount-hal pmount pumount
	dodoc AUTHORS CHANGES
}

pkg_postinst() {
	chown root:plugdev /usr/bin/pmount /usr/bin/pumount
	chmod 4770 /usr/bin/pmount /usr/bin/pumount

	einfo
	einfo "This package has been installed setuid.  The permissions are as such that"
	einfo "only users that belong to the plugdev group are allowed to run this."
	einfo
	einfo "Please add your user to the plugdev group to be able to mount USB drives"
}
