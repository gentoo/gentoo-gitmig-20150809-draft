# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/snavigator/snavigator-5.0.ebuild,v 1.10 2003/04/24 11:02:41 vapier Exp $

DESCRIPTION="Source-Navigator is a source code analysis tool"
SRC_URI="http://mirrors.rcn.com/pub/sourceware/sourcenav/releases/SN50-010322-source.tar.gz"
HOMEPAGE="http://sources.redhat.com/sourcenav/"

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="x86 sparc"

DEPEND=">=sys-libs/glibc-2.2.4"

S=${WORKDIR}/build

SN="/usr/snavigator"

src_unpack() {
	mkdir build
	unpack ${A}
}

src_compile() {
	../source/configure \
		--host=${CHOST} \
		--prefix=${SN} \
		--mandir=${SN}/share/man \
		--infodir=${SN}/share/info \
		--datadir=${SN}/share || die

	make all-snavigator || die
}

fix_makefile() {
	mv ${S}/$1/Makefile ${S}/$1/Makefile_orig
	sed -e "s:$2:$3:" \
		${S}/$1/Makefile_orig \
		> ${S}/$1/Makefile
}

fix_destdir() {
	fix_makefile "$1" "DESTDIR =" "DESTDIR = ${D}"
}

fix_destdir_bindir() {
	fix_makefile "$1" "\$(DESTDIR)\$(bindir)" "${D}${SN}/bin"
}

src_install() {
	# don't know why the DESTDIR var isn't propagated
	fix_destdir snavigator/misc/libutils
	fix_destdir snavigator/db
	fix_destdir snavigator/sdk/api/tcl/misc
	fix_destdir snavigator/sdk/api/c/database/examples
	fix_destdir snavigator/sdk/api/tcl/database/examples
	fix_destdir snavigator/sdk/parsers/examples/assembly
	fix_destdir snavigator/sdk/parsers/examples/elf
	fix_destdir snavigator/parsers/toolbox
	fix_destdir snavigator/demo
	fix_destdir snavigator/etc/sn_toolchains
	fix_destdir snavigator/etc

	# some strange propagation goes on here, just replacing it away
	fix_destdir_bindir snavigator/db
	fix_destdir_bindir snavigator/snavigator/unix
	fix_destdir_bindir snavigator/parsers/assembly/ppc601-eabi
	fix_destdir_bindir snavigator/parsers/cpp
	fix_destdir_bindir snavigator/parsers/fortran
	fix_destdir_bindir snavigator/hyper
	fix_destdir_bindir snavigator/parsers/java
	fix_destdir_bindir snavigator/parsers/m4
	fix_destdir_bindir snavigator/parsers/cobol
	fix_destdir_bindir snavigator/parsers/python
	fix_destdir_bindir snavigator/parsers/tcl

	fix_makefile snavigator/sdk/api/c/database/examples   "\$(DESTDIR)\$(cdbdir)"           "${D}/usr/snavigator/share/sdk/api/c/database/examples"
	fix_makefile snavigator/sdk/api/tcl/database/examples "\$(DESTDIR)\$(tcldbdir)"         "${D}/usr/snavigator/share/sdk/api/tcl/database/examples"
	fix_makefile snavigator/sdk/api/tcl/misc              "\$(DESTDIR)\$(misctcldir)"       "${D}/usr/snavigator/share/sdk/api/tcl/misc"
	fix_makefile snavigator/sdk/parsers/examples/assembly "\$(DESTDIR)\$(assemblydir)"      "${D}/usr/snavigator/share/sdk/parsers/examples/assembly"
	fix_makefile snavigator/sdk/parsers/examples/elf      "\$(DESTDIR)\$(elfdir)"           "${D}/usr/snavigator/share/sdk/parsers/examples/elf"
	fix_makefile snavigator/parsers/toolbox               "\$(DESTDIR)\$(sdkincludedir)"    "${D}/usr/snavigator/share/sdk/include"
	fix_makefile snavigator/etc/sn_toolchains             "\$(DESTDIR)\$(sn_toolchainsdir)" "${D}/usr/snavigator/share/etc/sn_toolchains"
	fix_makefile snavigator/etc                           "\$(DESTDIR)\$(etcdir)"           "${D}/usr/snavigator/share/etc"

	# other required fixes and vars that aren't propagated
	fix_makefile /                          "${SN}"                                         "${D}${SN}"
	fix_makefile snavigator/db              "NONE"                                          "${D}${SN}"
	fix_makefile snavigator/db              "\$(sdkdir)/libpafdb.a"                         "${D}/\$(sdkdir)/libpafdb.a"
	fix_makefile snavigator/sdk/api/c       "\$(datadir)/sdk/include"                       "${D}${SN}/share/sdk/include"
	fix_makefile snavigator/sdk             "${SN}/share/sdk/lib"                           "${D}${SN}/share/sdk/lib"
	fix_makefile snavigator/packages        "progdir = \$(datadir)"                         "progdir = ${D}${SN}/share"
	fix_makefile snavigator/gui             "progdir = \$(datadir)"                         "progdir = ${D}${SN}/share"
	fix_makefile snavigator/doc/html        "htmldir = \$(prefix)/html"                     "htmldir = ${D}/usr/share/doc/${P}/html"
	fix_makefile snavigator/doc/html        "create_index_file \$(srchtmldir) \$(prefix)"   "create_index_file \$(srchtmldir) ${D}/usr/share/doc/${P}"
	fix_makefile snavigator/demo            "demosdir = \$(datadir)"                        "demosdir = ${D}/usr/share/doc/${P}"
	fix_makefile snavigator/bitmaps         "imagedir = \$(datadir)"                        "imagedir = ${D}${SN}/share"
	fix_makefile snavigator/snavigator/unix "\$(bindir)/snavigator"                         "${D}${SN}/bin/snavigator"
	fix_makefile snavigator/install         "\$(DESTDIR)\$(rootdir)"                        "${D}/usr/share/doc/${P}/"
	fix_makefile snavigator                 "\$(prefix)"                                    "${D}/usr/share/doc/${P}/"
	fix_makefile tcl8.1/unix                "${SN}/share"                                   "${D}${SN}/share"
	fix_makefile tcl8.1/unix                "\$(INCLUDE_INSTALL_DIR)"                       "${D}${SN}/include"
	fix_makefile tk8.1/unix                 "${SN}/share"                                   "${D}${SN}/share"
	fix_makefile tk8.1/unix                 "\$(INCLUDE_INSTALL_DIR)"                       "${D}${SN}/include"
	fix_makefile tix/unix                   "\$(prefix)/share/tix"                          "${D}${SN}/share/tix"
	fix_makefile itcl/itcl/unix             "\$(INCLUDE_INSTALL_DIR)"                       "${D}${SN}/include"
	fix_makefile itcl/itcl/unix             "\$(prefix)/share/itcl"                         "${D}${SN}/share/itcl"
	fix_makefile itcl/itk/unix              "\$(INCLUDE_INSTALL_DIR)"                       "${D}${SN}/include"
	fix_makefile itcl/itk/unix              "\$(prefix)/share/itk"                          "${D}${SN}/share/itk"
	fix_makefile itcl/iwidgets3.0.0/unix    "IWIDGETS_LIBRARY = \$(datadir)"                "IWIDGETS_LIBRARY = ${D}${SN}/share"
	fix_makefile libgui/src                 "\$(includedir)"                                "${D}${SN}/include"
	fix_makefile libgui/library             "guidir = \$(datadir)"                          "guidir = ${D}${SN}/share"

	make DESTDIR=${D} \
		install-snavigator || die

	chmod -Rf 755 ${D}/usr/share/doc/${P}/demos
	dodir /etc/env.d
	echo "PATH=/usr/snavigator/bin" > ${D}/etc/env.d/10snavigator
}
