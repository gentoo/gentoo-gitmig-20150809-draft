# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/cm3-bin/cm3-bin-5.2.6.ebuild,v 1.6 2004/01/24 19:59:33 vapier Exp $

DESCRIPTION="Critical Mass Modula-3 compiler (binary version)"
HOMEPAGE="http://www.elegosoft.com/cm3/"
SRC_URI="x86? ( http://www.elegosoft.com/cm3/cm3-min-POSIX-LINUXLIBC6-${PV}.tgz )
	ppc? ( http://www.elegosoft.com/cm3/cm3-min-POSIX-PPC_LINUX-${PV}.tgz )"

LICENSE="CMASS-M3 DEC-M3"
KEYWORDS="x86 ppc"
SLOT="0"
IUSE=""

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	tar -zxf system.tgz || die "unpacking system.tgz"

	local TARGET
	local GNU_PLATFORM
	case ${ARCH} in
		x86)	TARGET=LINUXLIBC6
			GNU_PLATFORM=i486--linuxelf
			;;
		ppc)	TARGET=PPC_LINUX
			GNU_PLATFORM=powerpc-apple-linuxelf
			;;
	esac
	sed \
		-e "s:GENTOO_TARGET:${TARGET}:" \
		-e "s:GENTOO_GNU_PLATFORM:${GNU_PLATFORM}:" \
		-e "s:GENTOO_INITIAL_REACTOR_EDITOR:${EDITOR:-/usr/bin/nano}:" \
		-e "s:GENTOO_INSTALL_ROOT:/usr/lib/cm3/:" \
		-e "s:GENTOO_GNU_CC:${CC:-gcc}:" \
		-e "s:GENTOO_GNU_CFLAGS:${CFLAGS:--O}:" \
		-e "s:GENTOO_GNU_MAKE:${MAKE:-make}:" \
		-e "s:GENTOO_ROOT:/usr/lib/cm3/pkg/:" \
		${FILESDIR}/cm3.cfg > bin/cm3.cfg
}

src_install() {
	dodir /usr/lib/cm3 /usr/bin
	mv pkg bin lib ${D}/usr/lib/cm3/
	dosym /usr/lib/cm3/bin/cm3 /usr/bin/cm3
	dosym /usr/lib/cm3/bin/cm3.cfg /usr/bin/cm3.cfg
	dosym /usr/lib/cm3/bin/cm3cg /usr/bin/cm3cg
	dobin ${FILESDIR}/m3{build,ship}

	insinto /etc/env.d
	doins ${FILESDIR}/05cm3
}
