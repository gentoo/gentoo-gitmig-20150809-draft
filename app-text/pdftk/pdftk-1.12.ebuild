# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pdftk/pdftk-1.12.ebuild,v 1.9 2006/06/05 22:16:06 genstef Exp $

inherit eutils

DESCRIPTION="A tool for manipulating PDF documents"
HOMEPAGE="http://www.accesspdf.com/pdftk"
SRC_URI="http://www.pdfhacks.com/pdftk/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc"
IUSE="nodrm"
DEPEND="virtual/libc
	>=sys-devel/gcc-3.3"
S=${WORKDIR}/${P}/${PN}

pkg_setup() {
	if [ -z "$(which gcj 2>/dev/null)" ]; then
		eerror "It seems that your system doesn't provides a Java compiler."
		eerror "Re-emerge sys-devel/gcc with \"gcj\" enabled."
		die "gcj not found."
	fi
}

src_unpack() {
	unpack ${A}
	# force usage of custom CFLAGS.
	mv ${S}/Makefile.Generic ${T}/Makefile.Generic.orig
	sed 's:-O2:\$(CFLAGS):g' \
		< ${T}/Makefile.Generic.orig > ${S}/Makefile.Generic
	# Fix gcc-4 compilation, bug #126735.
	epatch "${FILESDIR}/${P}-gcc-4-compilation.patch" || die
	use nodrm && epatch "${FILESDIR}"/${P}-user-pw.patch
}

src_compile() {
	# java-config settings break compilation by gcj.
	unset CLASSPATH
	unset JAVA_HOME
	make -f Makefile.Generic || die "Compilation failed."
}

src_install() {
	dobin pdftk
	newman ../pdftk.1.txt pdftk.1
	dohtml ../pdftk.1.html
}
