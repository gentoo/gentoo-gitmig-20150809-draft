# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gradm/gradm-2.1.14.201005041005.ebuild,v 1.5 2010/08/16 17:13:21 blueness Exp $

EAPI=2

inherit flag-o-matic toolchain-funcs versionator

MY_PV="$(replace_version_separator 3 -)"

DESCRIPTION="Administrative interface for the grsecurity Role Based Access Control system"
HOMEPAGE="http://www.grsecurity.net/"
SRC_URI="mirror://gentoo/${PN}-${MY_PV}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ppc64 ~sparc x86"
IUSE="pam"

RDEPEND=""
DEPEND="sys-devel/bison
	sys-devel/flex
	pam? ( virtual/pam )
	|| ( sys-apps/paxctl sys-apps/chpax )"

S="${WORKDIR}/${PN}2"

src_prepare() {
	sed -i  -e s:^LDFLAGS=:LDFLAGS+=: \
		-e s:^MKNOD=.*:MKNOD=true: \
		-e s:^STRIP=.*:STRIP=true: Makefile

	append-ldflags -Wl,-z,now
}

src_compile() {
	local target
	use pam || target="nopam"

	emake ${target} CC="$(tc-getCC)" OPT_FLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	einstall DESTDIR="${D}" || die "einstall failed"
	fperms 711 /sbin/gradm
}

pkg_postinst() {
	[ -e "${ROOT}"/dev/grsec ] && rm -f "${ROOT}"/dev/grsec
	einfo "Making character device for grsec2 learning mode"
	mkdir -p -m 755 "${ROOT}"/dev/
	mknod -m 0622 "${ROOT}"/dev/grsec c 1 13 || die "mknod on grsec learning device failed"

	einfo
	ewarn "Be sure to set a password with 'gradm -P' before enabling learning mode"
	ewarn
	ewarn "This version of gradm is only supported with a kernel >=2.6.29!"
	einfo
}
