# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gradm/gradm-2.1.5.200504081812.ebuild,v 1.3 2005/09/17 15:05:20 swegener Exp $

inherit flag-o-matic toolchain-funcs versionator

myPV="$(replace_version_separator 3 -)"

DESCRIPTION="Administrative interface for the grsecurity Role Based Access Control system"
HOMEPAGE="http://www.grsecurity.net/"
SRC_URI="http://www.grsecurity.net/gradm-${myPV}.tar.gz"
#SRC_URI="mirror://gentoo/gradm-${myPV}.tar.gz"
#RESTRICT=primaryuri
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~arm ~amd64 ~ppc64 ~ia64 ~mips ~alpha"
IUSE=""
RDEPEND=""
DEPEND="virtual/libc
	sys-devel/bison
	sys-devel/flex
	|| (
		sys-apps/paxctl
		sys-apps/chpax
	)"

S="${WORKDIR}/${PN}2"

src_compile() {
	emake OPT_FLAGS="${CFLAGS}" CC="$(tc-getCC)" || die "compile problem"
}

src_install() {
	einstall DESTDIR="${D}" || die "einstall failed"
	fperms 711 /sbin/gradm
}

pkg_postinst() {
	if [ ! -e "${ROOT}"/dev/grsec ] ; then
		einfo "Making character device for grsec2 learning mode"
		mkdir -p -m 755 "${ROOT}"/dev/
		mknod -m 0622 "${ROOT}"/dev/grsec c 1 12 || die "Cant mknod for grsec learning device"
	fi
	ewarn "Be sure to set a password with 'gradm -P' before enabling learning mode"
}
