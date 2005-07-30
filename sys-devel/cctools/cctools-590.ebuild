# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/cctools/cctools-590.ebuild,v 1.1 2005/07/30 16:38:22 kito Exp $

inherit eutils darwin

DESCRIPTION="Darwin assembler and linker tools"
HOMEPAGE="http://darwinsource.opendarwin.org/"
SRC_URI="http://darwinsource.opendarwin.org/tarballs/apsl/${P}.tar.gz"

LICENSE="APSL-2"

SLOT="0"
KEYWORDS="~ppc-macos"
IUSE="build doc"

DEPEND="sys-libs/csu-darwin
	sys-libs/libstreams
	sys-libs/libc-darwin
	!sys-devel/cctools-extras"

src_unpack() {
	cd ${WORKDIR}
	unpack "${P}.tar.gz"
	
	cd ${WORKDIR}/${P}
	for GNUMAKEFILE in `find . -name Makefile -print` ; do
		sed -i -e 's:/usr/local:/usr:' ${GNUMAKEFILE} \
		|| die "sed ${GNUMAKEFILE} failed" 	
	done
#	epatch ${FILESDIR}/otool.patch
	cd ${WORKDIR}
	cp -r ${P} ${P}-ofiles
	sed -i -e 's:seg_hack:${S}/misc/seg_hack.NEW:' ${P}/ld/Makefile \
		|| die "sed bailed."
	sed -i -e 's:seg_hack:${D}/usr/bin/seg_hack:' ${P}-ofiles/ld/Makefile \
		|| die "sed bailed."
	sed -i -e 's:nmedit:${T}/build/sym/misc/nmedit.NEW:' ${P}-ofiles/ld/Makefile \
                || die "sed bailed."
}

src_install() {
	darwinmake || die "make install failed"
	
	cd ${WORKDIR}/${P}-ofiles
	mkdir -p ${WORKDIR}/${P}-ofiles/build/obj ${WORKDIR}/${P}-ofiles/build/sym
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
		dodoc ${D}/usr/RelNotes/*.html
	fi

	doditto ${D}/usr/local/libexec ${D}/usr/libexec

	rm -rf ${D}/usr/local ${D}/usr/RelNotes ${D}/usr/bin/nmedit
	newbin ${T}/build/sym/misc/nmedit.NEW nmedit
}

