# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gradm/gradm-2.1.8.200601212342-r1.ebuild,v 1.6 2006/04/09 16:29:17 corsair Exp $

inherit flag-o-matic toolchain-funcs eutils versionator

myPV="$(replace_version_separator 3 -)"

DESCRIPTION="Administrative interface for the grsecurity Role Based Access Control system"
HOMEPAGE="http://www.grsecurity.net/"
SRC_URI="http://www.grsecurity.net/gradm-${myPV}.tar.gz"
#SRC_URI="mirror://gentoo/gradm-${myPV}.tar.gz"
#RESTRICT=primaryuri
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ia64 ~mips ppc ppc64 ~sparc x86"
IUSE="pam"
RDEPEND=""
DEPEND="virtual/libc
	sys-devel/bison
	sys-devel/flex
	pam? ( virtual/pam )
	|| (
		sys-apps/paxctl
		sys-apps/chpax
	)"

S="${WORKDIR}/${PN}2"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/2.1.7.200511041858-non-lazy-bindings.patch

	# All of these patches can be dropped in gradm-2.1.9
	epatch "${FILESDIR}/${PN}_${PV}-fix_gradm_pam_symlinks.patch"
	epatch "${FILESDIR}/${PN}_${PV}-increase_num_pointers.patch"
	epatch "${FILESDIR}/${PN}_${PV}-ip_state_interface_fix.patch"
}

src_compile() {
	local target=""
	use pam || target="nopam"

	emake ${target} CC="$(tc-getCC)" OPT_FLAGS="${CFLAGS}" || die "compile problem"
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
