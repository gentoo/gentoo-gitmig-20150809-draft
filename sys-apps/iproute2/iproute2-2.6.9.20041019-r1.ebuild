# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/iproute2/iproute2-2.6.9.20041019-r1.ebuild,v 1.1 2004/12/05 08:55:22 vapier Exp $

inherit eutils toolchain-funcs

MY_PV="${PV:0:5}"
SNAP="${PV:${#PV}-6}"
DESCRIPTION="kernel routing and traffic control utilities"
HOMEPAGE="http://developer.osdl.org/dev/iproute2/"
SRC_URI="http://developer.osdl.org/dev/iproute2/download/${PN}-${MY_PV}-${SNAP}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="atm minimal"

RDEPEND="virtual/libc
	!minimal? ( sys-libs/db )
	atm? ( net-dialup/linux-atm )"
DEPEND="${RDEPEND}
	>=virtual/os-headers-2.4.21
	>=sys-apps/sed-4"

S=${WORKDIR}/${PN}-${MY_PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s:-O2:${CFLAGS}:g" Makefile || die "sed Makefile failed"
	#68948 - esqf/wrr patches
	epatch \
		${FILESDIR}/2.6.9.20040831-make-install.patch \
		${FILESDIR}/${PV}-esqf.patch \
		${FILESDIR}/${PV}-wrr.patch
}

src_compile() {
	# non-standard configure script
	./configure || die "configure"
	use atm \
		&& sed -i '/TC_CONFIG_ATM/s:=.*:=y:' Config \
		|| sed -i '/TC_CONFIG_ATM/s:=.*:=n:' Config

	local SUBDIRS="lib ip tc misc"
	use minimal && SUBDIRS="lib tc"
	emake \
		CC="$(tc-getCC)" \
		KERNEL_INCLUDE="${ROOT}/usr/include" \
		SUBDIRS="${SUBDIRS}" || die "make"
}

src_install() {
	if use minimal; then
		into /
		dosbin tc/tc || die "minimal"
		return 0
	fi

	make \
		DESTDIR=${D} \
		SBINDIR=/sbin \
		DOCDIR=/usr/share/doc/${PF} \
		install || die "make install failed"
	into /
	dosbin ip/{ifcfg,rtpr} || die "dosbin failed"
}
