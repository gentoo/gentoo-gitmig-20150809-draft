# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gradm/gradm-2.1.12.200812271437.ebuild,v 1.2 2009/01/25 00:55:48 gengor Exp $

inherit flag-o-matic toolchain-funcs eutils versionator

myPV="$(replace_version_separator 3 -)"

DESCRIPTION="Administrative interface for the grsecurity Role Based Access Control system"
HOMEPAGE="http://www.grsecurity.net/"
SRC_URI="mirror://gentoo/gradm-${myPV}.tar.gz"
#RESTRICT=primaryuri
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86"
IUSE="pam"
RDEPEND=""
DEPEND="virtual/libc
	sys-devel/bison
	sys-devel/flex
	pam? ( virtual/pam )
	|| ( sys-apps/paxctl sys-apps/chpax )"

S="${WORKDIR}/${PN}2"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/2.1.7.200511041858-non-lazy-bindings.patch
	sed -i -e s/MKNOD=/'MKNOD ?='/ -e s/STRIP=/'STRIP ?='/ "${S}/Makefile"
}

src_compile() {
	local target=""
	use pam || target="nopam"

	emake ${target} CC="$(tc-getCC)" OPT_FLAGS="${CFLAGS}" || die "compile problem"
}

src_install() {
	einstall DESTDIR="${D}" MKNOD=true STRIP=true || die "einstall failed"
	fperms 711 /sbin/gradm
}

pkg_postinst() {
	[ -e "${ROOT}"/dev/grsec ] && rm -f "${ROOT}"/dev/grsec
	einfo "Making character device for grsec2 learning mode"
	mkdir -p -m 755 "${ROOT}"/dev/
	mknod -m 0622 "${ROOT}"/dev/grsec c 1 13 || die "Cant mknod for grsec learning device"

	ewarn "Be sure to set a password with 'gradm -P' before enabling learning mode"
	ewarn
	ewarn "This version of gradm is only useful/supported with a kernel >=2.6.25!"
}
