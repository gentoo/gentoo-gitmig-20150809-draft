# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gnustep-make/gnustep-make-1.2.1.ebuild,v 1.5 2002/08/16 04:04:41 murphy Exp $

DESCRIPTION="GNUstep makefile package (stable)"
HOMEPAGE="http://www.gnustep.org"
LICENSE="LGPL"
DEPEND="virtual/glibc
	>=sys-devel/gcc-3.1
	>=dev-libs/ffcall-1.8d
	>=dev-libs/gmp-3.1.1
	>=dev-util/guile-1.4
	>=dev-libs/openssl-0.9.6d
	>=media-libs/tiff-3.5.7-r1
	>=dev-libs/libxml2-2.4.22
	>=x11-wm/WindowMaker-0.80.1"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/core/${P}.tar.gz"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

src_compile() {
	./configure \
		--host=${CHOST} || die "./configure failed"
	emake || die
}

src_install () {
	mkdir -p ${D}/usr ${D}/usr/GNUstep ${D}/usr/GNUstep/System \
	${D}/usr/GNUstep/System/Makefiles \
        ${D}/usr/GNUstep/System/Makefiles/ix86 \
        ${D}/usr/GNUstep/System/Makefiles/ix86/linux-gnu \
        ${D}/usr/GNUstep/System/Makefiles/Additional \
        ${D}/usr/GNUstep/System/Tools \
        ${D}/usr/GNUstep/System/share \
        ${D}/usr/GNUstep/System/Apps \
        ${D}/usr/GNUstep/System/Libraries/ix86/linux-gnu/gnu-gnu-gnu \
        ${D}/usr/GNUstep/System/Libraries/Resources \
        ${D}/usr/GNUstep/System/Libraries/Java \
        ${D}/usr/GNUstep/System/Headers/ix86/linux-gnu \
        ${D}/usr/GNUstep/System/Tools/ix86/linux-gnu/gnu-gnu-gnu \
        ${D}/usr/GNUstep/System/Tools/Java \
        ${D}/usr/GNUstep/System/Library/Bundles \
        ${D}/usr/GNUstep/System/Library/Colors \
        ${D}/usr/GNUstep/System/Library/Frameworks \
        ${D}/usr/GNUstep/System/Library/PostScript \
        ${D}/usr/GNUstep/System/Library/Services \
        ${D}/usr/GNUstep/System/Documentation/Developer \
        ${D}/usr/GNUstep/System/Documentation/User \
        ${D}/usr/GNUstep/System/Documentation/info \
        ${D}/usr/GNUstep/System/Documentation/man \
        ${D}/usr/GNUstep/System/Developer/Palettes \
 	${D}/usr/GNUstep/Local/Apps \
        ${D}/usr/GNUstep/Local/Libraries/ix86/linux-gnu/gnu-gnu-gnu \
        ${D}/usr/GNUstep/Local/Libraries/Resources \
        ${D}/usr/GNUstep/Local/Libraries/Java \
        ${D}/usr/GNUstep/Local/Headers/ix86/linux-gnu \
        ${D}/usr/GNUstep/Local/Tools/ix86/linux-gnu/gnu-gnu-gnu \
        ${D}/usr/GNUstep/Local/Tools/Java \
        ${D}/usr/GNUstep/Local/Library/Bundles \
        ${D}/usr/GNUstep/Local/Library/Colors \
        ${D}/usr/GNUstep/Local/Library/Frameworks \
        ${D}/usr/GNUstep/Local/Library/PostScript \
        ${D}/usr/GNUstep/Local/Library/Services \
        ${D}/usr/GNUstep/Local/Documentation/Developer \
        ${D}/usr/GNUstep/Local/Documentation/User \
        ${D}/usr/GNUstep/Local/Developer/Palettes \
        ${D}/usr/GNUstep/Local/Users \
        ${D}/usr/GNUstep/Local/Users/Administrator \
        ${D}/usr/GNUstep/Network
	
	insinto /usr/GNUstep/System/Makefiles/ix86/linux-gnu
	doins which_lib config.make

	insinto /usr/GNUstep/System/Makefiles
	doins config.guess config.sub install-sh mkinstalldirs \
		GNUstep.sh MediaBook.sh clean_cpu.sh clean_os.sh \
		clean_vendor.sh cpu.sh 	ld_lib_path.sh 	os.sh \
		transform_paths.sh vendor.sh GNUstep.csh \
		ld_lib_path.csh cygpath.sh aggregate.make \
		application.make bundle.make service.make common.make \
		library-combo.make java.make jni.make library.make \
		rules.make target.make names.make tool.make ctool.make \
		test-library.make objc.make test-application.make \
		test-tool.make subproject.make palette.make gswapp.make \
		gswbundle.make clibrary.make documentation.make \
		MediaBook.func executable.template java-executable.template \
		java-tool.make framework.make source-distribution.make \
		rpm.make spec-rules.template spec-debug-rules.template \
		spec-debug-alone-rules.template

	insinto /usr/GNUstep/System/Tools
	doins openapp debugapp opentool

	insinto /usr/GNUstep/System/share
	doins config.site
}
