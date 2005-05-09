# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pmount/pmount-0.8.9.31.ebuild,v 1.1 2005/05/09 18:31:28 cardoe Exp $

inherit eutils

DESCRIPTION="Mount removable devices as a normal user"
SRC_URI="http://dev.gentoo.org/~npmccallum/distfiles/${P}.tar.gz"
#The real SRC_URI for when upstream releases
#SRC_URI="http://www.piware.de/projects/${PN}-${PV}.tar.gz"
HOMEPAGE="http://www.piware.de/projects.shtml/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=""

DEPEND="${RDEPEND}
	>=sys-fs/sysfsutils-1.0"

DOCS="AUTHORS GPL CHANGES README"

src_install () {

	into /usr
	dobin pmount-hal pmount pumount || die
	dodoc AUTHORS CHANGES GPL README

}

pkg_preinst() {

	enewgroup plugdev || die "Error creating plugdev group"

}

pkg_postinst() {

	chown root:plugdev /usr/bin/pmount /usr/bin/pumount
	chmod 4770 /usr/bin/pmount /usr/bin/pumount

	einfo
	einfo This package has been installed setuid.  The permissions are as such that
	einfo only users that belong to the plugdev group are allowed to run this.
	einfo please see the README file for information about the constraints of pmount
	einfo

}
