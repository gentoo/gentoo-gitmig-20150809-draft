# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/sbcl-mt/sbcl-mt-0.8.5.ebuild,v 1.1 2003/11/10 00:52:37 mkennedy Exp $

inherit common-lisp-common

DEB_PV=1

DESCRIPTION="Steel Bank Common Lisp (SBCL) is a Open Source development system for ANSI Common Lisp. It provides an interactive environment including an integrated native compiler, interpreter, and debugger.  This is the multreaded version of SBCL"
HOMEPAGE="http://sbcl.sourceforge.net/"
BV_X86=0.8.1
SRC_URI="http://ftp.debian.org/debian/pool/main/s/sbcl/sbcl_${PV}.orig.tar.gz
	x86? ( mirror://sourceforge/sbcl/sbcl-${BV_X86}-x86-linux-binary.tar.bz2 )"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
PROVIDE="virtual/commonlisp"
# the SRC_URI trickery needs this
DEPEND=">=sys-apps/portage-2.0.27
	dev-lisp/common-lisp-controller
	doc? ( app-text/openjade )"

S=${WORKDIR}/sbcl-${PV}

src_unpack() {
	if use x86; then
		unpack sbcl-${BV_X86}-x86-linux-binary.tar.bz2
		mv sbcl-${BV_X86} x86-binary
	fi
	unpack sbcl_${PV}.orig.tar.gz
	epatch ${FILESDIR}/sbcl-${PV}-mt-gentoo.patch
	cp ${FILESDIR}/customize-target-features.lisp ${S}/
}

src_compile() {
	local bindir
	use x86 && bindir=../x86-binary
#	use ppc && bindir=../ppc-binary
#	use sparc && bindir=../sparc-binary
#	use mips && bindir=../mips-binary
	# TODO: allow the user to chose between SBCL, CMUCL and CLISP for bootstrapping
	PATH=${bindir}/src/runtime:${PATH} SBCL_HOME=${bindir}/output GNUMAKE=make \
		./make.sh 'sbcl --sysinit /dev/null --userinit /dev/null --noprogrammer --core ${bindir}/output/sbcl.core' || die
	if use doc; then
		cd doc && chmod +x make-doc.sh
		./make-doc.sh
	fi
}

src_install() {
	unset SBCL_HOME

	insinto /etc/
	doins ${FILESDIR}/sbcl-mt.rc

	exeinto /usr/lib/common-lisp/bin
	doexe ${FILESDIR}/sbcl-mt.sh

	INSTALL_ROOT=${D}/usr sh install.sh
	mv ${D}/usr/lib/sbcl ${D}/usr/lib/sbcl-mt
	mv ${D}/usr/bin/sbcl ${D}/usr/bin/sbcl-mt
	dosym /usr/lib/sbcl-mt/asdf-install/asdf-install /usr/bin/sbcl-mt-asdf-install
	rm ${D}/usr/bin/sbcl-asdf-install
	mv ${D}/usr/lib/sbcl-mt/sbcl.core ${D}/usr/lib/sbcl-mt/sbcl-dist.core

	insinto /usr/lib/sbcl-mt
	doins ${FILESDIR}/install-clc.lisp

	dodir /usr/share
	mv ${D}/usr/man ${D}/usr/share/
	mv ${D}/usr/share/man/man1/sbcl.1 ${D}/usr/share/man/man1/sbcl-mt.1

#	doman debian/sbcl-asdf-install.1

	use doc && dohtml doc/html/*
	dodoc BUGS COPYING CREDITS INSTALL NEWS OPTIMIZATIONS PRINCIPLES \
		README STYLE TLA TODO
#	do-debian-credits

	find ${D} -type f -name .cvsignore -exec rm -f '{}' \;
	find ${D} -type f -name \*.c -exec chmod 644 '{}' \;

	# BIG FAT HACK
	#
	# Since the Portage emerge step kills file timestamp information,
	# we need to compensate by ensuring all .fasl files are more
	# recent than their .lisp source.

	dodir /usr/share/${PN}
	tar cpvzf ${D}/usr/share/${PN}/portage-timestamp-compensate -C ${D}/usr/lib/${PN} .
}

pkg_postinst() {
	tar xvpzf /usr/share/sbcl-mt/portage-timestamp-compensate -C /usr/lib/sbcl-mt
	rm -rf /usr/lib/common-lisp/${PN}/* || true
	/usr/bin/clc-autobuild-impl sbcl-mt yes
	rm -rf /usr/lib/common-lisp/${PN} || true
	/usr/sbin/register-common-lisp-implementation sbcl-mt
}

pkg_postrm() {
	# Since we keep our own time stamps we must manually remove them
	# here.
	if [ ! -x /usr/bin/sbcl-mt ]; then
		rm -rf /usr/lib/sbcl-mt
	fi
}
