# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/cryptsetup/cryptsetup-0.1.ebuild,v 1.2 2004/07/22 07:30:22 mr_bones_ Exp $

DESCRIPTION="Tool to setup encrypted devices with dm-crypt"
HOMEPAGE="http://www.saout.de/misc/dm-crypt/"
SRC_URI="http://www.saout.de/misc/dm-crypt/${PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=sys-libs/device-mapper-1.00.07-r1
		>=dev-libs/libgcrypt-1.1.42"

IUSE=""

S=${WORKDIR}/${PN}-${PV}

pkg_setup() {
	if ! grep CONFIG_DM_CRYPT /usr/src/linux/.config > /dev/null 2>&1
	then
		ewarn "dm-crypt is not enabled in /usr/src/linux/.config"
		ewarn "please see $HOMEPAGE"
		ewarn "for details on how to enable dm-crypt for your kernel"
	fi
}

src_compile() {
	cd ${S}

	econf --bindir=/bin --disable-nls|| die

	sed -i -e 's|-lgcrypt|/usr/lib/libgcrypt.a|' Makefile src/Makefile
	sed -i -e 's|-lgpg-error|/usr/lib/libgpg-error.a|' Makefile src/Makefile
	sed -i -e 's|-lpopt|/usr/lib/libpopt.a|' src/Makefile

	emake || die
}

src_install() {
	make DESTDIR=${D} install
}
