# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/openwrt-cvs/openwrt-cvs-20040807.ebuild,v 1.2 2004/09/03 15:18:18 dholm Exp $

ECVS_SERVER="openwrt.ksilebo.net:/openwrt"
ECVS_PASS="anonymous"
ECVS_MODULE="buildroot"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/${P}"

inherit cvs

LINKSYS_REVISION=2.07.1

DESCRIPTION="OpenWrt is a linux firmware distribution for the Linksys WRT54G."
HOMEPAGE="http://openwrt.ksilebo.net/"

# These variables can override the OpenWrt defaults if they are
# exported, but for stablility we don't.
GCC_VERSION=3.3.3
#SNAPSHOT=20040705
SNAPSHOT=20040807
BINUTILS_VERSION=2.14.90.0.7

SRC_URI="mirror://gnu/gcc-${GCC_VERSION}/gcc-${GCC_VERSION}.tar.bz2
	mirror://gentoo/binutils-${BINUTILS_VERSION}.tar.bz2
	http://www.uclibc.org/downloads/snapshots/uClibc-${SNAPSHOT}.tar.bz2
	mirror://gentoo/wrt54gs.${LINKSYS_REVISION}.tgz"
#	http://www.linksys.com/support/opensourcecode/wrt54gs/${LINKSYS_REVISION}/wrt54gs.${LINKSYS_REVISION}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

DEPEND=">=sys-apps/sed-4
	dev-util/patchutils
	sys-devel/gcc
	sys-devel/make
	net-misc/wget
	sys-apps/coreutils
	sys-devel/gettext"

RDEPEND=""

S="${WORKDIR}/${ECVS_MODULE}"

src_unpack() {
	if [ "${ECVS_SERVER}" == "offline" ] ; then
		# unpack ${A}
		die "The cvs is unreachable at this time. A direct internet connection is required for this task."
	else
		cvs_src_unpack
	fi

	cd ${S} || die
	# we want to cacehe as many of the bug downloads as we can in
	# the $PORTDIR/distfiles/
	mkdir -p sources/dl/
	cd sources/dl/
	for f in wrt54gs.${LINKSYS_REVISION}.tgz gcc-${GCC_VERSION}.tar.bz2 \
			uClibc-${SNAPSHOT}.tar.bz2 binutils-${BINUTILS_VERSION}.tar.bz2 ; do
		ln -s ${DISTDIR}/${f} ${f}
	done
}

src_compile() {
	#export SNAPSHOT GCC_VERSION
	env MAKEOPTS="" emake PACKAGES="" SQUASHFS_SOURCE=squashfs2.0.tar.gz \
		JLEVEL="${MAKEOPTS}" || die "make failed"
}

src_install() {
	dodir /usr/share/${PN}/$(date -u +%Y%m%d)/
	cp openwrt-{g{,s}-code.bin,linux.trx,kmodules.tar.gz} \
		${D}/usr/share/${PN}/$(date -u +%Y%m%d)/
	dodoc *README*

	return 0

	# install the mipsel cross-compiler for later use.
	local TARGET_ARCH=mipsel
	[ -e "${ROOT}/usr/${TARGET_ARCH}-linux-uclibc" ] && return 0

	dodir /usr/lib/gcc-lib/
	cp -a ${S}/build_${TARGET_ARCH}/staging_dir/lib/gcc-lib/${TARGET_ARCH}-linux-uclibc ${D}/usr/lib/gcc-lib/

	dodir /usr/${TARGET_ARCH}-linux-uclibc/gcc-bin/
	cp -a ${S}/build_${TARGET_ARCH}/staging_dir/bin/* ${D}/usr/${TARGET_ARCH}-linux-uclibc/gcc-bin/${GCC_VERSION:0:3}/

	cd ${D}/usr/${TARGET_ARCH}-linux-uclibc/gcc-bin/${GCC_VERSION:0:3}/
	for f in gcc g++ c++ ; do ln -s ${TARGET_ARCH}-linux-uclibc-$f $f ; done

	dodir /usr/${TARGET_ARCH}-linux-uclibc/bin/
	cd ${D}/usr/${TARGET_ARCH}-linux-uclibc/bin/
	for f in addr2line ar as c++filt gprof ld nm objcopy objdump \
		ranlib readelf size strings strip; do
		ln -s ../gcc-bin/3.3/${TARGET_ARCH}-linux-uclibc-$f $f
	done

	dodir /etc/env.d/${TARGET_ARCH}-linux-uclibc-${GCC_VERSION}
	cat <<__EOF__>> ${D}/etc/env.d/mipsel-linux-uclibc-${GCC_VERSION}
CROSS_ARCH=${TARGET_ARCH}
CROSS_LIBC=uclibc
CBUILD=\${CROSS_ARCH}-linux-\${CROSS_LIBC}
CROSS_PREFIX=\${CROSS_TARGET}-
PATH="/usr/\${CROSS_ARCH}-linux-\${CROSS_LIBC}/gcc-bin/${GCC_VERSION:0:3}"
ROOTPATH="/usr/\${CROSS_ARCH}-linux-\${CROSS_LIBC}/gcc-bin/${GCC_VERSION:0:3}"
LDPATH="/usr/lib/gcc-lib/\${CROSS_ARCH}-linux-\${CROSS_LIBC}/${GCC_VERSION}"
MANPATH="/usr/share/gcc-data/\${CROSS_ARCH}-linux-\${CROSS_LIBC}/${GCC_VERSION:0:3}/man"
INFOPATH="/usr/share/gcc-data/\${CROSS_ARCH}-linux-\${CROSS_LIBC}/${GCC_VERSION:0:3}/info"
STDCXX_INCDIR="g++-v${GCC_VERSION:0:1}"
CC="\${CROSS_PREFIX}gcc"
CXX="\${CROSS_PREFIX}g++"
__EOF__
}

pkg_postinst() {
	einfo "Please follow the instructions outlined on the webpage at ${HOMEPAGE} and in the README"
}
