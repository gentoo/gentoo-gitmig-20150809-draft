# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/iproute2/iproute2-2.6.9.20040831.ebuild,v 1.3 2004/12/01 14:52:37 gustavoz Exp $

inherit eutils gcc

MY_PV="${PV:0:5}"
SNAP="${PV:${#PV}-6}"
DESCRIPTION="kernel routing and traffic control utilities"
HOMEPAGE="http://developer.osdl.org/dev/iproute2/"
SRC_URI="http://developer.osdl.org/dev/iproute2/download/${PN}-${MY_PV}-ss${SNAP}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm hppa ia64 ~mips ~ppc ~ppc64 sparc x86"
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
	epatch ${FILESDIR}/${PV}-make-install.patch
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
		CC="$(gcc-getCC)" \
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
