# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/sbcl/sbcl-0.8.8.ebuild,v 1.3 2004/03/24 04:21:49 mkennedy Exp $

inherit common-lisp-common

DESCRIPTION="Steel Bank Common Lisp (SBCL) is an implementation of ANSI Common Lisp."
HOMEPAGE="http://sbcl.sourceforge.net/"
IUSE="threads"
BV_X86=0.8.1
BV_PPC=0.7.13
BV_SPARC=0.7.13
BV_MIPS=0.7.10
SRC_URI="mirror://sourceforge/sbcl/${P}-source.tar.bz2
	mirror://sourceforge/sbcl/${P}-html.tar.bz2
	x86? ( mirror://sourceforge/sbcl/${PN}-${BV_X86}-x86-linux-binary.tar.bz2 )
	ppc? ( mirror://sourceforge/sbcl/${PN}-${BV_PPC}-binary-linux-ppc.tar.bz2 )
	sparc? ( mirror://sourceforge/sbcl/${PN}-${BV_SPARC}-sparc-linux-binary.tar.bz2 )
	mips? ( mirror://sourceforge/sbcl/${PN}-${BV_MIPS}-mips-linux-binary.tar.gz )"
LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~mips"
PROVIDE="virtual/commonlisp"
DEPEND="dev-lisp/common-lisp-controller"

S=${WORKDIR}/${P}

src_unpack() {
	if use x86; then
		unpack ${PN}-${BV_X86}-x86-linux-binary.tar.bz2
		mv ${PN}-${BV_X86} x86-binary
	elif use ppc; then
		unpack ${PN}-${BV_PPC}-ppc-binary-linux.tar.bz2
		mv ${PN}-${BV_PPC}-ppc-linux ppc-binary
	elif use sparc; then
		unpack ${PN}-${BV_SPARC}-sparc-linux-binary.tar.bz2
		echo mv ${PN}-${BV_SPARC} sparc-binary || die
		mv ${PN}-${BV_SPARC} sparc-binary || die
	elif use mips; then
		unpack ${PN}-${BV_SPARC}-mips-linux-binary.tar.gz
		mv ${PN}-${BV_SPARC}-mips-linux mips-binary
	fi

	unpack ${P}-source.tar.bz2
	epatch ${FILESDIR}/${PV}/sbcl-gentoo.patch

	# Currently, thread support is only available for x86.	These
	# features expressions also disable :sb-test.
	if use x86 && use threads; then
		cp ${FILESDIR}/${PV}/customize-target-features.lisp \
			${S}/customize-target-features.lisp
	else
		cp ${FILESDIR}/${PV}/customize-target-features.lisp.no-threads \
			${S}/customize-target-features.lisp
	fi

	find ${S} -type f -name .cvsignore -exec rm -f '{}' \;
	find ${S} -type d -name CVS \) -exec rm -rf '{}' \;
	find ${S} -type f -name \*.c -exec chmod 644 '{}' \;
}

src_compile() {
	local bindir
	use x86 && bindir=../x86-binary
	use ppc && bindir=../ppc-binary
	use sparc && bindir=../sparc-binary
	use mips && bindir=../mips-binary
	# TODO: allow the user to chose between SBCL, CMUCL and CLISP for bootstrapping
	# build with previous SBCL
	PATH=${bindir}/src/runtime:${PATH} SBCL_HOME=${bindir}/output GNUMAKE=make \
		./make.sh 'sbcl --sysinit /dev/null --userinit /dev/null --noprogrammer --core ${bindir}/output/sbcl.core'
	# build with CMUCL
#	GNUMAKE=make ./make.sh 'lisp -batch'
}

src_install() {
	unset SBCL_HOME

	insinto /etc/
	doins ${FILESDIR}/${PV}/sbcl.rc	# Gentoo specific (from Debian)

	exeinto /usr/lib/common-lisp/bin
	doexe ${FILESDIR}/${PV}/sbcl.sh	# Gentoo specific (from Debian)

	dodir /usr/share/man
	INSTALL_ROOT=${D}/usr sh install.sh
	mv ${D}/usr/lib/sbcl/sbcl.core ${D}/usr/lib/sbcl/sbcl-dist.core

	insinto /usr/lib/sbcl
	doins ${FILESDIR}/${PV}/install-clc.lisp	# Gentoo specific (from Debian)

	doman ${FILESDIR}/${PV}/sbcl-asdf-install.1	# Gentoo specific (from Debian)

	dodoc BUGS COPYING CREDITS INSTALL NEWS OPTIMIZATIONS PRINCIPLES README STYLE SUPPORT TLA TODO

	dodoc ${FILESDIR}/${PV}/README.Gentoo
	dohtml doc/html/*

	keepdir /usr/lib/common-lisp/sbcl


	impl-save-timestamp-hack sbcl || die
}

pkg_postinst() {
	standard-impl-postinst sbcl
}

pkg_postrm() {
	standard-impl-postrm sbcl /usr/bin/sbcl
}
