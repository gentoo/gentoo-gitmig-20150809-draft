# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/sbcl/sbcl-0.8.7-r1.ebuild,v 1.1 2004/01/29 03:54:31 mkennedy Exp $

inherit common-lisp-common

DESCRIPTION="Steel Bank Common Lisp (SBCL) is an implementation of ANSI Common Lisp."
HOMEPAGE="http://sbcl.sourceforge.net/"
IUSE="threads"
BV_X86=0.8.1
BV_PPC=0.7.13
BV_SPARC=0.7.13
BV_MIPS=0.7.10
DEB_PV=1
SRC_URI="http://ftp.debian.org/debian/pool/main/s/sbcl/sbcl_${PV}.orig.tar.gz
	mirror://sourceforge/sbcl/${P}-html.tar.bz2
	http://ftp.debian.org/debian/pool/main/s/sbcl/sbcl_${PV}-${DEB_PV}.diff.gz
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
	unpack sbcl_${PV}.orig.tar.gz
	unpack sbcl_${PV}-${DEB_PV}.diff.gz
	epatch sbcl_${PV}-${DEB_PV}.diff

	epatch ${FILESDIR}/${PV}/posix-tests.lisp-sandbox-gentoo.patch
	epatch ${FILESDIR}/${PV}/install-clc.lisp-gentoo.patch

	# Currently, thread support is only available for x86.	These
	# features expressions also disable :sb-test.
	if use x86 && use threads; then
		cp ${FILESDIR}/${PV}/customize-target-features.lisp \
			${S}/customize-target-features.lisp
	else
		cp ${FILESDIR}/${PV}/customize-target-features.lisp.no-threads \
			${S}/customize-target-features.lisp
	fi
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
	doins ${FILESDIR}/sbcl.rc	# Gentoo specific messages, hence ${FILESDIR}

	exeinto /usr/lib/common-lisp/bin
	doexe debian/sbcl.sh

	dodir /usr/share/man
	INSTALL_ROOT=${D}/usr sh install.sh
	mv ${D}/usr/lib/sbcl/sbcl.core ${D}/usr/lib/sbcl/sbcl-dist.core

	insinto /usr/lib/sbcl
	doins debian/install-clc.lisp

	doman debian/sbcl-asdf-install.1
	dodoc BUGS COPYING CREDITS INSTALL NEWS OPTIMIZATIONS PRINCIPLES README STYLE SUPPORT TLA TODO
	do-debian-credits
	dodoc ${FILESDIR}/${PV}/README.Gentoo
	dohtml doc/html/*

	find ${D} -type f -name .cvsignore -exec rm -f '{}' \;
	find ${D} -type f -name \*.c -exec chmod 644 '{}' \;

	keepdir /usr/lib/common-lisp/sbcl

	# BIG FAT HACK
	#
	# Since the Portage emerge step kills file timestamp information,
	# we need to compensate by ensuring all .fasl files are more
	# recent than their .lisp source.

	dodir /usr/share/${PN}
	tar cpjf ${D}/usr/share/${PN}/portage-timestamp-compensate -C ${D}/usr/lib/${PN} .
}

pkg_postinst() {
	chown cl-builder:cl-builder /usr/lib/common-lisp/sbcl
	tar xvjpfo /usr/share/sbcl/portage-timestamp-compensate -C /usr/lib/sbcl
	chown -R root:root /usr/lib/sbcl
	rm -rf /usr/lib/common-lisp/sbcl/* || true
	/usr/bin/clc-autobuild-impl sbcl yes
	register-common-lisp-implementation sbcl
}

pkg_postrm() {
	# Since we keep our own time stamps we must manually remove them
	# here.
	if [ ! -x /usr/bin/sbcl ]; then
		rm -rf /usr/lib/sbcl
	fi
	rm -rf /usr/lib/common-lisp/${PN}/*
}
