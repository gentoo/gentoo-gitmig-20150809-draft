# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/mkxf86config/mkxf86config-0.9.10.ebuild,v 1.5 2013/03/22 10:26:47 ssuominen Exp $

EAPI=5

DESCRIPTION="X.org (X11) configuration builder for LiveCDs"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~x86"
IUSE=""

RDEPEND="!mips? ( sys-apps/hwsetup )"

pkg_setup() {
	ewarn "This package is designed for use on the LiveCD only and will do "
	ewarn "unspeakably horrible and unexpected things on a normal system."
	ewarn "YOU HAVE BEEN WARNED!!!"
}

src_install() {
	dosbin ${PN}.sh

	insinto /etc/X11
	if use mips; then
		doins xorg.conf.impact xorg.conf.newport xorg.conf.o2-fbdev
	else
		doins xorg.conf.in
	fi

	newinitd "${FILESDIR}"/${PN}.initd ${PN}
}
