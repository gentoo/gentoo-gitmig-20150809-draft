# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-base/gnustep-make/gnustep-make-1.3.4.ebuild,v 1.1 2004/07/23 13:51:21 fafhrd Exp $

IUSE=""

DESCRIPTION="GNUstep makefile package (unstable)"
HOMEPAGE="http://www.gnustep.org"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/core/${P}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="x86 sparc "
SLOT="0"

DEPEND="virtual/libc
	>=sys-devel/gcc-3.1
	>=dev-libs/ffcall-1.8d
	>=dev-libs/gmp-3.1.1
	>=dev-util/guile-1.4
	>=dev-libs/openssl-0.9.6d
	>=media-libs/tiff-3.5.7-r1
	>=dev-libs/libxml2-2.4.22"

src_compile() {
	./configure \
		--host=${CHOST} || die "./configure failed"
	emake || die
}

src_install () {
	dodir   /usr/GNUstep/System \
		/usr/GNUstep/System/Makefiles \
		/usr/GNUstep/System/Makefiles/ix86 \
		/usr/GNUstep/System/Makefiles/ix86/linux-gnu \
		/usr/GNUstep/System/Makefiles/Additional \
		/usr/GNUstep/System/Makefiles/Master \
		/usr/GNUstep/System/Makefiles/Instance \
		/usr/GNUstep/System/Makefiles/Instance/Shared \
		/usr/GNUstep/System/Tools \
		/usr/GNUstep/System/share \
		/usr/GNUstep/System/Applications \
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
		/usr/GNUstep/Local/Applications \
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
	insopts -m 755
	doins which_lib user_home

	insinto /usr/GNUstep/System/Makefiles
	insopts -m 755
	doins config.guess config.sub install-sh mkinstalldirs \
		clean_cpu.sh clean_os.sh clean_vendor.sh cpu.sh \
		ld_lib_path.sh os.sh transform_paths.sh vendor.sh \
		ld_lib_path.csh fixpath.sh relative_path.sh \
		GNUstep.sh GNUstep-reset.sh GNUstep.csh

	insinto /usr/GNUstep/System/Tools
	insopts -m 755
	doins openapp debugapp opentool

	insinto /usr/GNUstep/System/Makefiles
	insopts -m 644
	doins aggregate.make application.make bundle.make service.make \
		common.make library-combo.make java.make jni.make \
		library.make rules.make target.make names.make \
		resource-set.make tool.make ctool.make test-library.make \
		objc.make test-application.make test-tool.make \
		subproject.make palette.make gswapp.make gswbundle.make \
		clibrary.make documentation.make java-executable.template \
		java-tool.make framework.make spec-rules.template \
		spec-debug-rules.template spec-debug-alone-rules.template \
		executable.template messages.make

	cd ./Master
	insinto /usr/GNUstep/System/Makefiles/Master
	insopts -m 644
	doins aggregate.make source-distribution.make rpm.make rules.make \
		application.make bundle.make clibrary.make ctool.make \
		documentation.make framework.make gswapp.make \
		gswbundle.make 	library.make objc.make java.make \
		java-tool.make palette.make resource-set.make service.make \
		subproject.make test-application.make test-library.make \
		test-tool.make tool.make

	cd ../Instance
	insinto /usr/GNUstep/System/Makefiles/Instance
	insopts -m 644
	doins rules.make application.make bundle.make clibrary.make \
		ctool.make documentation.make framework.make gswapp.make \
		gswbundle.make library.make objc.make java.make \
		java-tool.make palette.make resource-set.make service.make \
		subproject.make test-application.make test-library.make \
		test-tool.make tool.make

	cd ./Shared
	insinto /usr/GNUstep/System/Makefiles/Instance/Shared
	insopts -m 644
	doins bundle.make headers.make java.make

	cd ../../
	insinto /usr/GNUstep/System/share
	insopts -m 644
	doins config.site

	insinto /usr/GNUstep/System/Makefiles/ix86/linux-gnu
	insopts -m 644
	doins config.make
}
