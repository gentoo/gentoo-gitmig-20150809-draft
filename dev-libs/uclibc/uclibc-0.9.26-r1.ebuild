# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/uclibc/uclibc-0.9.26-r1.ebuild,v 1.2 2004/02/01 09:41:56 solar Exp $

inherit eutils

MY_P="${P/ucl/uCl}"
DESCRIPTION="C library for developing embedded Linux systems"
HOMEPAGE="http://www.uclibc.org/"
SRC_URI="http://www.kernel.org/pub/linux/libs/uclibc/${MY_P}.tar.bz2"
IUSE="pie"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips"

DEPEND="sys-devel/gcc"
PROVIDE="virtual/glibc"

S=${WORKDIR}/${MY_P}

src_unpack() {
	local PIE=0
	local SSP=0

	unpack ${A}
	cd ${S}

	if [ "${PV}" == "0.9.26" ] ; then
		# patch needed to really enable FORCE_SHAREABLE_SEGMENTS
		# when building pic code. submitted by Peter S. Mazinger
		epatch ${FILESDIR}/${PV}/uClibc-${PV}-pie-option.patch
		epatch ${FILESDIR}/${PV}/uClibc-${PV}-Makefile.patch
	fi

	# fixup for install perms
	sed -i -e "s:-fa:-dRf:g" Makefile

	make defconfig >/dev/null || die "could not config"
	for def in UCLIBC_{HAS_LOCALE,PROFILING} DO{DEBUG,ASSERTS} SUPPORT_LD_DEBUG{,_EARLY} ; do
		sed -i "s:${def}=y:# ${def} is not set:" .config
	done

	if [ `use x86` ] ; then
		use pie && PIC=1
		[ "`is-flag -fPIC`" == "true" ] && PIC=1
	fi

	[ "`is-flag -fstack-protector`" == "true" ] && SSP=1
	[ "`is-flag -fstack-protector-all`" == "true" ] && SSP=1

	if [ "${PIC}" == 1 ] ; then
		einfo "Enable Position Independent Executable support in ${P}"
		sed -i -e "s:# UCLIBC_PIE_SUPPORT.*:UCLIBC_PIE_SUPPORT=y:" .config
		sed -i -e "s:# UCLIBC_PIE_SUPPORT.*:UCLIBC_PIE_SUPPORT=y:" .config
	fi
	if [ "${SSP}" == 1 ]; then
		einfo "Enable Stack Smashing Protections support in ${P}"
		sed -i -e "s:# UCLIBC_PROPOLICE.*:UCLIBC_PROPOLICE=y:" .config
	fi

	cp .config myconfig

	emake clean >/dev/null || die "could not clean"
}

src_compile() {
	mv myconfig .config
	emake -j1 || die "could not make"
}

src_install() {
	emake PREFIX=${D} install || die "install failed"
}
