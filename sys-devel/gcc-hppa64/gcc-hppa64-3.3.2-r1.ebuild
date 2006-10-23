# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc-hppa64/gcc-hppa64-3.3.2-r1.ebuild,v 1.7 2006/10/23 15:41:46 gustavoz Exp $

inherit eutils


# Variables
MYARCH="$(echo ${PN} | cut -d- -f2)"
TMP_P="${P/-${MYARCH}/}"
TMP_PN="${PN/-${MYARCH}/}"
I="/usr"


DESCRIPTION="Gcc for 64bit hppa kernels"
HOMEPAGE="http://www.gnu.org/software/gcc/gcc.html"
SRC_URI="ftp://gcc.gnu.org/pub/gcc/releases/${TMP_P}/${TMP_P}.tar.bz2"
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"

KEYWORDS="-* hppa"
IUSE="build"

DEPEND="virtual/libc
	!sys-devel/kgcc64
	>=sys-devel/binutils-hppa64-2.14.90.0.7
	>=sys-devel/binutils-2.14.90.0.7
	|| ( >=sys-devel/gcc-config-1.3.1 app-admin/eselect-compiler )"

RDEPEND="virtual/libc
	|| ( >=sys-devel/gcc-config-1.3.1 app-admin/eselect-compiler )
	>=sys-libs/zlib-1.1.4
	>=sys-apps/texinfo-4.2-r4
	!build? ( >=sys-libs/ncurses-5.2-r2 )"

TARGET=hppa64-linux

version_patch() {
	[ ! -f "$1" ] && return 1
	[ -z "$2" ] && return 1

	sed -e "s:@GENTOO@:$2:g" ${1} > ${T}/${1##*/}
	epatch ${T}/${1##*/}
}

src_unpack() {
	unpack ${TMP_P}.tar.bz2
	cd ${WORKDIR}
	ln -s ${TMP_P} ${P}
	cd ${S}

	# Make gcc's version info specific to Gentoo
	if [ -z "${PP_VER}" ]; then
		version_patch ${FILESDIR}/${TMP_P}-gentoo-branding.patch \
			"(Gentoo Linux ${PVR})" || die "Failed Branding"
	fi

	epatch ${FILESDIR}/${TMP_P}-rtl-optimization.patch
}

src_compile() {
	cd ${WORKDIR}

	# Build in a separate build tree
	mkdir -p ${WORKDIR}/build
	cd ${WORKDIR}/build

	einfo "Configuring GCC..."

	addwrite "/dev/zero"
	${S}/configure --prefix=${I} \
		--build=hppa-linux \
		--host=hppa-linux \
		--disable-shared \
		--without-libc \
		--enable-languages=c \
		--target=${TARGET} \
		${myconf} || die

	einfo "Building GCC..."
	S="${WORKDIR}/build" \
	emake CPATH=/usr/include CFLAGS="${CFLAGS}" || die
}

src_install() {
	# Do allow symlinks in ${I}/lib/gcc-lib/${CHOST}/${PV}/include as
	# this can break the build.
	for x in cd ${WORKDIR}/build/gcc/include/*
	do
		if [ -L ${x} ]
		then
			rm -f ${x}
		fi
	done

	einfo "Installing GCC..."
	# Do the 'make install' from the build directory
	cd ${WORKDIR}/build
	S="${WORKDIR}/build" \
	make prefix=${D}${I} \
		FAKE_ROOT="${D}" \
		install || die

	#Remove unneeded files

	for i in lib/libiberty.a man share include info
	do
		rm -R ${D}/usr/${i}
	done
}
