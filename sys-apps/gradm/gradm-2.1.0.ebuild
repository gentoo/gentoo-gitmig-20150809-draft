# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gradm/gradm-2.1.0.ebuild,v 1.2 2005/01/11 22:45:18 solar Exp $

inherit flag-o-matic gcc eutils

MAINTAINER="solar@gentoo.org"
DESCRIPTION="Administrative interface for grsecuritys2 access control lists"
HOMEPAGE="http://www.grsecurity.net/"
SRC_URI="http://www.grsecurity.net/gradm-${PV}-200501071935.tar.gz"
#SRC_URI="mirror://gentoo/gradm-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc arm amd64"
IUSE=""
RDEPEND=""
DEPEND="virtual/libc
	sys-devel/bison
	sys-devel/flex
	sys-apps/chpax"

S="${WORKDIR}/${PN}2"

src_unpack() {
	unpack ${A}
	cd ${S}

	ebegin "Patching Makefile to use gentoo CFLAGS"
	sed -i -e "s|-O2|${CFLAGS}|" Makefile
	eend $?
}

src_compile() {
	cd ${S}
	emake CC="$(gcc-getCC)" || die "compile problem"
	return 0
}

src_install() {
	cd ${S}
	einstall DESTDIR=${D}
	fperms 711 /sbin/gradm
	return 0
}

pkg_postinst() {
	if [ ! -e /dev/grsec ] ; then
		einfo "Making character device for grsec2 learning mode"
		mkdir -p -m 755 /dev/
		mknod -m 0622 /dev/grsec c 1 12 || die "Cant mknod for grsec learning device"
	fi
	ewarn "Be sure to set a password with 'gradm -P' before enabling learning mode"
}
