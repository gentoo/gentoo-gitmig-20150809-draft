# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/sbcl/sbcl-0.8.5-r1.ebuild,v 1.3 2003/12/27 17:28:16 weeve Exp $

inherit common-lisp-common

DESCRIPTION="Steel Bank Common Lisp (SBCL) is a Open Source development system for ANSI Common Lisp. It provides an interactive environment including an integrated native compiler, interpreter, and debugger. (And it, and its generated code, can also play nicely with Unix when running noninteractively.)"
HOMEPAGE="http://sbcl.sourceforge.net/"
BV_X86=0.8.1
BV_PPC=0.7.13
BV_SPARC=0.7.13
BV_MIPS=0.7.10
DEB_PV=1
SRC_URI="http://ftp.debian.org/debian/pool/main/s/sbcl/sbcl_${PV}.orig.tar.gz
	http://ftp.debian.org/debian/pool/main/s/sbcl/sbcl_${PV}-${DEB_PV}.diff.gz
	x86? ( mirror://sourceforge/sbcl/${PN}-${BV_X86}-x86-linux-binary.tar.bz2 )
	ppc? ( mirror://sourceforge/sbcl/${PN}-${BV_PPC}-binary-linux-ppc.tar.bz2 )
	sparc? ( mirror://sourceforge/sbcl/${PN}-${BV_SPARC}-sparc-linux-binary.tar.bz2 )
	mips? ( mirror://sourceforge/sbcl/${PN}-${BV_MIPS}-mips-linux-binary.tar.gz )"
LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~mips"
PROVIDE="virtual/commonlisp"
# the SRC_URI trickery needs this
DEPEND=">=sys-apps/portage-2.0.27
	dev-lisp/common-lisp-controller
	doc? ( app-text/openjade )"

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
}

src_compile() {
	local bindir
	use x86 && bindir=../x86-binary
	use ppc && bindir=../ppc-binary
	use sparc && bindir=../sparc-binary
	use mips && bindir=../mips-binary
	# TODO: allow the user to chose between SBCL, CMUCL and CLISP for bootstrapping
	PATH=${bindir}/src/runtime:${PATH} SBCL_HOME=${bindir}/output GNUMAKE=make \
		./make.sh 'sbcl --sysinit /dev/null --userinit /dev/null --noprogrammer --core ${bindir}/output/sbcl.core'
	if use doc; then
		cd doc && chmod +x make-doc.sh
		./make-doc.sh
	fi
}

src_install() {
	unset SBCL_HOME

	insinto /etc/
	doins ${FILESDIR}/sbcl.rc

	exeinto /usr/lib/common-lisp/bin
	doexe ${FILESDIR}/sbcl.sh

	INSTALL_ROOT=${D}/usr sh install.sh
	dosym /usr/lib/sbcl/asdf-install/asdf-install /usr/bin/sbcl-asdf-install
	mv ${D}/usr/lib/sbcl/sbcl.core ${D}/usr/lib/sbcl/sbcl-dist.core

	insinto /usr/lib/sbcl
	doins ${FILESDIR}/install-clc.lisp

	dodir /usr/share
	mv ${D}/usr/man ${D}/usr/share/
	doman debian/sbcl-asdf-install.1

	use doc && dohtml doc/html/*
	dodoc BUGS COPYING CREDITS INSTALL NEWS OPTIMIZATIONS PRINCIPLES README STYLE TLA TODO

	do-debian-credits

	find ${D} -type f -name .cvsignore -exec rm -f '{}' \;
	find ${D} -type f -name \*.c -exec chmod 644 '{}' \;

	keepdir /usr/lib/common-lisp/sbcl

	# BIG FAT HACK
	#
	# Since the Portage emerge step kills file timestamp information,
	# we need to compensate by ensuring all .fasl files are more
	# recent than their .lisp source.

	dodir /usr/share/${PN}
	tar cpvzf ${D}/usr/share/${PN}/portage-timestamp-compensate -C ${D}/usr/lib/${PN} .
}

pkg_postinst() {
	chown cl-builder:cl-builder /usr/lib/common-lisp/sbcl
	tar xvpzf /usr/share/sbcl/portage-timestamp-compensate -C /usr/lib/sbcl
	rm -rf /usr/lib/common-lisp/sbcl/* || true
	/usr/bin/clc-autobuild-impl sbcl yes
	/usr/sbin/register-common-lisp-implementation sbcl
}

pkg_postrm() {
	# Since we keep our own time stamps we must manually remove them
	# here.
	if [ ! -x /usr/bin/sbcl ]; then
		rm -rf /usr/lib/sbcl
	fi
	rm -rf /usr/lib/common-lisp/${PN}/*
}
