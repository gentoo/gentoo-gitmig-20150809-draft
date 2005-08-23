# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gradm/gradm-2.1.6.200506131347.ebuild,v 1.3 2005/08/23 20:22:55 agriffis Exp $

inherit flag-o-matic toolchain-funcs eutils

myPV=${PV:0:5}-${PV:6}

MAINTAINER="solar@gentoo.org"
DESCRIPTION="Administrative interface for the grsecurity Role Based Access Control system"
HOMEPAGE="http://www.grsecurity.net/"
SRC_URI="http://www.grsecurity.net/gradm-${myPV}.tar.gz"
#SRC_URI="mirror://gentoo/gradm-${myPV}.tar.gz"
#RESTRICT=primaryuri
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ia64 ~mips ppc ~ppc64 ~sparc x86"
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

	#epatch ${FILESDIR}/gradm-2.1.2-non-interactive.patch

	ebegin "Patching Makefile to use gentoo CFLAGS"
	sed -i -e "s|-O2|${CFLAGS}|" Makefile
	eend $?
}

src_compile() {
	cd ${S}
	emake CC="$(tc-getCC)" || die "compile problem"
	return 0
}

src_install() {
	cd ${S}
	einstall DESTDIR=${D}
	fperms 711 /sbin/gradm
	return 0
}

pkg_postinst() {
	if [ ! -e ${ROOT}/dev/grsec ] ; then
		einfo "Making character device for grsec2 learning mode"
		mkdir -p -m 755 ${ROOT}/dev/
		mknod -m 0622 ${ROOT}/dev/grsec c 1 12 || die "Cant mknod for grsec learning device"
	fi
	ewarn "Be sure to set a password with 'gradm -P' before enabling learning mode"
}
