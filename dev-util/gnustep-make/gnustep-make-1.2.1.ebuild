# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gnustep-make/gnustep-make-1.2.1.ebuild,v 1.10 2003/02/28 16:54:59 liquidx Exp $

DESCRIPTION="GNUstep makefile package (stable)"
HOMEPAGE="http://www.gnustep.org"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/core/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 sparc "

DEPEND="virtual/glibc
	>=sys-devel/gcc-3.1
	>=dev-libs/ffcall-1.8d
	>=dev-libs/gmp-3.1.1
	>=dev-util/guile-1.4
	>=dev-libs/openssl-0.9.6d
	>=media-libs/tiff-3.5.7-r1
	>=dev-libs/libxml2-2.4.22
	>=x11-wm/WindowMaker-0.80.1"

src_compile() {
	econf
	emake || die
}

src_install() {
	dodir /usr /usr/GNUstep /usr/GNUstep/System \
		/usr/GNUstep/System/Makefiles \
	        /usr/GNUstep/System/Makefiles/ix86 \
	        /usr/GNUstep/System/Makefiles/ix86/linux-gnu \
	        /usr/GNUstep/System/Makefiles/Additional \
	        /usr/GNUstep/System/Tools \
	        /usr/GNUstep/System/share \
	        /usr/GNUstep/System/Apps \
	        /usr/GNUstep/System/Libraries/ix86/linux-gnu/gnu-gnu-gnu \
	        /usr/GNUstep/System/Libraries/Resources \
	        /usr/GNUstep/System/Libraries/Java \
	        /usr/GNUstep/System/Headers/ix86/linux-gnu \
		/usr/GNUstep/System/Tools/ix86/linux-gnu/gnu-gnu-gnu \
		/usr/GNUstep/System/Tools/Java \
		/usr/GNUstep/System/Library/Bundles \
		/usr/GNUstep/System/Library/Colors \
		/usr/GNUstep/System/Library/Frameworks \
		/usr/GNUstep/System/Library/PostScript \
		/usr/GNUstep/System/Library/Services \
		/usr/GNUstep/System/Documentation/Developer \
		/usr/GNUstep/System/Documentation/User \
		/usr/GNUstep/System/Documentation/info \
		/usr/GNUstep/System/Documentation/man \
		/usr/GNUstep/System/Developer/Palettes \
		/usr/GNUstep/Local/Apps \
		/usr/GNUstep/Local/Libraries/ix86/linux-gnu/gnu-gnu-gnu \
		/usr/GNUstep/Local/Libraries/Resources \
		/usr/GNUstep/Local/Libraries/Java \
		/usr/GNUstep/Local/Headers/ix86/linux-gnu \
		/usr/GNUstep/Local/Tools/ix86/linux-gnu/gnu-gnu-gnu \
		/usr/GNUstep/Local/Tools/Java \
		/usr/GNUstep/Local/Library/Bundles \
		/usr/GNUstep/Local/Library/Colors \
		/usr/GNUstep/Local/Library/Frameworks \
		/usr/GNUstep/Local/Library/PostScript \
		/usr/GNUstep/Local/Library/Services \
		/usr/GNUstep/Local/Documentation/Developer \
		/usr/GNUstep/Local/Documentation/User \
		/usr/GNUstep/Local/Developer/Palettes \
		/usr/GNUstep/Local/Users \
		/usr/GNUstep/Local/Users/Administrator \
		/usr/GNUstep/Network

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
