# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/uclibc/uclibc-0.9.23.ebuild,v 1.2 2004/01/04 05:32:52 solar Exp $

inherit eutils

MY_P="${P/ucl/uCl}"
DESCRIPTION="C library for developing embedded Linux systems"
HOMEPAGE="http://www.uclibc.org/"
SRC_URI="http://www.kernel.org/pub/linux/libs/uclibc/${MY_P}.tar.bz2"
IUSE="etdyn"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips"

DEPEND="sys-devel/gcc"
PROVIDE="virtual/glibc"

S=${WORKDIR}/${MY_P}

src_unpack() {
	local patches="uClibc-${PV}-flipturn.patch"
	use etdyn && patches="${patches} uClibc-${PV}-pax.patch uClibc-${PV}-etdyn.patch"

	unpack ${A}
	cd ${S}

	for patch in ${patches} ; do
		[ -f ${FILESDIR}/${PV}/${patch} ] && epatch ${FILESDIR}/${PV}/${patch}
	done

	# fixup for install perms
	sed -i -e "s:-fa:-dRf:g" Makefile

	make defconfig || die "could not config"
	for def in UCLIBC_{HAS_LOCALE,PROFILING} DO{DEBUG,ASSERTS} SUPPORT_LD_DEBUG{,_EARLY} ; do
		sed -i "s:${def}=y:# ${def} is not set:" .config
	done
	cp .config myconfig

	for f in `grep -Rl 'subst -g' *` ; do
		sed -i -e "/subst -g/s:-g:\\' -g \\':" ${f}
	done

	emake clean || die "could not clean"
}

src_compile() {
	mv myconfig .config
	make || die "could not make"
}

src_install() {
	make PREFIX=${D} install || die "install failed"
}
