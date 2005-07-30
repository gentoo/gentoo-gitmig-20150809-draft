# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: 

inherit eutils

DESCRIPTION="Darwin/OS X core system library"
HOMEPAGE="http://darwinsource.opendarwin.org/"
SRC_URI="http://darwinsource.opendarwin.org/tarballs/apsl/Libsystem-${PV}.tar.gz"

LICENSE="APSL-2"

SLOT="0"
KEYWORDS="~ppc-macos"
IUSE="build"

#	sys-libs/libm-darwin

DEPEND="sys-apps/bootstrap_cmds
	=sys-devel/gcc-apple-1*
	sys-libs/csu-darwin
	sys-libs/keymgr-darwin
	sys-libs/libc-darwin
	sys-libs/libinfo-darwin
	sys-libs/libkvm-darwin
	sys-libs/libnotify-darwin
	sys-libs/libstreams
	sys-libs/libwrappers-darwin
	sys-libs/unc-darwin"

S=${WORKDIR}/Libsystem-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	#epatch ${FILESDIR}/Libc-Makefile.patch
	sed -i -e 's|/usr/local|${D}/usr|g' ${S}/Makefile.xbs
	sed -i -e 's|/usr/local|${D}/usr|g' ${S}/GNUmakefile
}

src_compile() {

	local BUILDTARGETS
	# just ppc for now, TODO ppc64 i{3,6}86
	# we need debug later on down the food chain TODO relieve this dep and IUSE=debug
	# in macos, .a does NOT imply static, build-${ARCH}-dynamic gives you libc.a so 
	# that doesn't get built here but later when its rolled into libSystem
	BUILDTARGETS="build-ppc-static build-ppc-profile build-ppc-debug"

	mkdir -p ${S}/build/obj ${S}/build/sym
	gnumake \
	RC_OS=macos RC_ARCHS=ppc TARGETS=ppc \
	SRCROOT="${S}" OBJROOT="${S}"/build/obj \
	DSTROOT="${D}" SYMROOT="${S}"/build/sym \
	${BUILDTARGETS} || die "make ${BUILDTARGETS} failed."

}

src_install() {
	BUILDTARGETS="installhdrs"

	use ! build && BUILDTARGETS="${BUILDTARGETS} install-man"

	cd ${S}
	gnumake \
	RC_OS=macos RC_ARCHS=ppc TARGETS=ppc \
	SRCROOT="${S}" OBJROOT="${S}"/build/obj \
	DSTROOT="${D}" SYMROOT="${S}"/build/sym \
	${BUILDTARGETS} || die "build ${BUILDTARGETS} failed."

	into /usr/lib/system
	dolib.a ${S}/build/obj/obj.ppc/*.a

	insinto /usr/include
	doins ${S}/nls/FreeBSD/*.h

	use build && rm -rf ${D}/usr/share
	rm -rf ${D}/var
}

