# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pmount/pmount-0.9.13.ebuild,v 1.12 2007/03/28 13:01:40 armin76 Exp $

inherit eutils flag-o-matic

DESCRIPTION="Policy based mounter that gives the ability to mount removable devices as a user"
HOMEPAGE="http://www.piware.de/projects.shtml"
SRC_URI="http://www.piware.de/projects/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm hppa ia64 ppc ppc64 sh sparc x86"
IUSE="crypt hal"

DEPEND="hal? ( >=sys-apps/dbus-0.33 >=sys-apps/hal-0.5.2 )
	>=sys-fs/sysfsutils-1.3.0
	crypt? ( sys-fs/cryptsetup-luks )"

pkg_setup() {
	enewgroup plugdev
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch ${FILESDIR}/${PN}-0.9.13-no_close.patch
	append-ldflags $(bindnow-flags)
}

src_compile() {
	econf $(use_enable hal) \
		--with-cryptsetup-prog=/bin/cryptsetup
	emake || die "emake failed"
}

src_install () {
	# this is where we mount stuff
	# moved to hal as of 0.5.7-r1
	#keepdir /media

	# Must be run SETUID
	exeinto /usr/bin
	exeopts -m 4710 -g plugdev
	doexe src/pmount src/pumount src/pmount-hal

	dodoc AUTHORS ChangeLog TODO
	doman man/pmount.1 man/pumount.1 man/pmount-hal.1

	insinto /etc
	doins etc/pmount.allow
}

pkg_postinst() {
	elog
	elog "This package has been installed setuid.  The permissions are as such that"
	elog "only users that belong to the plugdev group are allowed to run this."
	elog
	elog "Please add your user to the plugdev group to be able to mount USB drives"
}
