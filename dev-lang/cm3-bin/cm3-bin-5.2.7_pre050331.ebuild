# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/cm3-bin/cm3-bin-5.2.7_pre050331.ebuild,v 1.1 2005/04/02 04:11:02 vapier Exp $

inherit toolchain-funcs

STAMP=${PV/*_pre}
MY_PV=${PV/_pre*}-20${STAMP:0:2}-${STAMP:2:2}-${STAMP:4:2}
DESCRIPTION="Critical Mass Modula-3 compiler (binary version)"
HOMEPAGE="http://www.elegosoft.com/cm3/"
SRC_URI="x86? ( http://www.elegosoft.com/cm3/cm3-min-POSIX-LINUXLIBC6-d${MY_PV}.tgz )
	amd64? ( http://www.elegosoft.com/cm3/cm3-min-POSIX-LINUXLIBC6-d${MY_PV}.tgz )"

LICENSE="CMASS-M3 DEC-M3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="amd64? ( app-emulation/emul-linux-x86-glibc )"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	tar -zxf system.tgz || die "unpacking system.tgz"

	local TARGET
	local GNU_PLATFORM
	case ${ARCH} in
		amd64|x86)
			TARGET=LINUXLIBC6
			GNU_PLATFORM=i486--linuxelf
			;;
		ppc)
			TARGET=PPC_LINUX
			GNU_PLATFORM=powerpc-apple-linuxelf
			;;
	esac
	sed \
		-e "s:GENTOO_TARGET:${TARGET}:" \
		-e "s:GENTOO_GNU_PLATFORM:${GNU_PLATFORM}:" \
		-e "s:GENTOO_INITIAL_REACTOR_EDITOR:${EDITOR:-/usr/bin/nano}:" \
		-e "s:GENTOO_INSTALL_ROOT:/usr/lib/cm3/:" \
		-e "s:GENTOO_GNU_CC:$(tc-getCC):" \
		-e "s:GENTOO_GNU_CFLAGS:${CFLAGS:--O}:" \
		-e "s:GENTOO_GNU_MAKE:${MAKE:-make}:" \
		-e "s:GENTOO_ROOT:/usr/lib/cm3/pkg/:" \
		"${FILESDIR}"/cm3.cfg > bin/cm3.cfg
}

src_install() {
	dodir /usr/lib/cm3 /usr/bin
	mv pkg bin lib "${D}"/usr/lib/cm3/ || die "mv lib"
	dosym /usr/lib/cm3/bin/cm3 /usr/bin/cm3
	dosym /usr/lib/cm3/bin/cm3.cfg /usr/bin/cm3.cfg
	dosym /usr/lib/cm3/bin/cm3cg /usr/bin/cm3cg
	dobin "${FILESDIR}"/m3{build,ship}

	doenvd "${FILESDIR}"/05cm3
}
