# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/uclibc++/uclibc++-0.1.8.ebuild,v 1.2 2005/01/10 13:55:03 vapier Exp $

inherit eutils

DESCRIPTION="embedded C++ library"
HOMEPAGE="http://cxx.uclibc.org/"
SRC_URI="http://cxx.uclibc.org/src/uClibc++-${PV}.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~ppc ~x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/uClibc++

src_unpack() {
	unpack ${A}
	cd ${S}
	make defconfig || die "defconfig failed"

	export CTARGET="${CTARGET:-${CHOST}}"
	local target
	case ${CTARGET} in
		arm*)		target="arm";;
		mips*)		target="mips";;
		powerpc*)	target="powerpc";;
		i?86*)		target="i386";;
		*)			die "${CTARGET} lists no defaults :/";;
	esac

	sed -i \
		-e '/^UCLIBCXX_RUNTIME_PREFIX=/d' \
		-e '/^TARGET_'${target}'/d' \
		.config

	cat << EOF >> .config
TARGET_${target}=y
UCLIBCXX_RUNTIME_PREFIX="/usr/${CTARGET}"
EOF
	echo "TARGET_${target}=y" >> .config

	yes "" | make oldconfig || die "oldconfig failed"

	# Patches!
	epatch "${FILESDIR}"/${PV}-pop_back.patch
}

src_compile() {
	emake -j1 CROSS=${CTARGET}- || die "make failed"
}

src_install() {
	make install PREFIX="${D}" || die
	dodir /usr/bin
	dosym /usr/${CTARGET}/bin/g++-uc /usr/bin/g++-uc
	dodoc ChangeLog README TODO
}
