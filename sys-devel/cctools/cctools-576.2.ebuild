# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/cctools/cctools-576.2.ebuild,v 1.1 2005/07/30 16:38:22 kito Exp $

inherit eutils

DESCRIPTION="Darwin assembler and linker tools"
HOMEPAGE="http://darwinsource.opendarwin.org/"
SRC_URI="http://darwinsource.opendarwin.org/tarballs/apsl/${P}.tar.gz"

LICENSE="APSL-2"

SLOT="0"
KEYWORDS="~ppc-macos"
IUSE="build doc"

DEPEND="sys-apps/bootstrap_cmds
	sys-libs/csu-darwin
	sys-libs/libstreams
	sys-libs/libc-darwin
	!sys-devel/cctools-extras"

src_unpack() {
	cd ${WORKDIR}
	unpack "${P}.tar.gz"

	epatch ${FILESDIR}/${P}.patch

	cp -r ${P} ${P}-ofiles
	sed -i -e 's:seg_hack:${S}/misc/seg_hack.NEW:' ${P}/ld/Makefile \
		|| die "sed bailed."
	sed -i -e 's:seg_hack:${D}/usr/bin/seg_hack:' ${P}-ofiles/ld/Makefile \
		|| die "sed bailed."
}
src_compile() {
	:
}

src_install() {
	mkdir -p ${S}/build/obj ${S}/build/sym \
	${WORKDIR}/${P}-ofiles/build/obj ${WORKDIR}/${P}-ofiles/build/sym

	cd ${S}
	export MACOSX_DEPLOYMENT_TARGET=10.4
	make RC_CFLAGS="-L/usr/lib/gcc/powerpc-apple-darwin8/4.0.0 -lgcc" \
	LD="gcc" \
	SRCROOT="${S}" OBJROOT="${S}/build/obj" \
	SYMROOT="${S}/build/sym" DSTROOT="${D}" \
	RC_OS=macos install || die "make install failed"
	
	cd ${WORKDIR}/${P}-ofiles
	make \
	RC_CFLAGS="-DMAC_OS_X_VERSION_MIN_REQUIRED=1040" \
	SRCROOT=${WORKDIR}/${P}-ofiles OBJROOT=${WORKDIR}/${P}-ofiles/build/obj \
	SYMROOT=${WORKDIR}/${P}-ofiles/build/sym DSTROOT=${D} \
	RC_OS=macos ofiles_install \
	|| die "make ofiles_install failed"

	insinto /usr
	doins -r ${S}/include

	insinto /usr/lib/system
	insopts -m0644
	doins ${WORKDIR}/${P}-ofiles/build/sym/libdyld/*.a
	if use build; then
		rm -rf ${D}/Developer ${D}/usr/share
	else
		dodoc ${D}/us/local/RelNotes/*.html
	fi
	rm -rf ${D}/usr/local
}

