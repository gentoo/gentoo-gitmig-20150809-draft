# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/sbcl/sbcl-0.8.3.ebuild,v 1.2 2003/11/14 11:41:53 seemant Exp $

DESCRIPTION="Steel Bank Common Lisp"
HOMEPAGE="http://sbcl.sourceforge.net/"
BV_X86=0.8.1
BV_PPC=0.7.13
SRC_URI="mirror://sourceforge/sbcl/${P}-source.tar.bz2
	x86? ( mirror://sourceforge/sbcl/${PN}-${BV_X86}-x86-linux-binary.tar.bz2 )
	ppc? ( mirror://sourceforge/sbcl/${PN}-${BV_PPC}-binary-linux-ppc.tar.bz2 )
	mirror://sourceforge/sbcl/${P}-html.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~ppc -sparc "
PROVIDE="virtual/commonlisp"
# the SRC_URI trickery needs this
DEPEND=">=sys-apps/portage-2.0.27
	dev-lisp/common-lisp-controller"

src_unpack() {

	if ( use x86 ) ; then
		unpack ${PN}-${BV_X86}-x86-linux-binary.tar.bz2
		mv ${PN}-${BV_X86} x86-binary
	elif ( use ppc ) ; then
		unpack ${PN}-${BV_PPC}-ppc-linux-binary.tar.bz2
		mv ${PN}-${BV_PPC}-ppc-linux ppc-binary
	fi

	unpack ${P}-source.tar.bz2
	unpack ${P}-html.tar.bz2
}

src_compile() {
	local bindir
	use x86 && bindir=x86-binary
	use ppc && bindir=ppc-binary

	#export INSTALL_ROOT=${D}/usr
	#export SBCL_HOME=${D}/usr/lib/sbcl
	export SBCL_HOME=../${bindir}/output
	export GNUMAKE="make"

	sh make.sh "../${bindir}/src/runtime/sbcl" || die
	sh make-target-contrib.sh || die
}

src_install() {
	local LIB=${DESTTREE}/lib/sbcl

	doman doc/sbcl.1
	dobin src/runtime/sbcl

	dodoc BUGS CREDITS NEWS README INSTALL COPYING
	dohtml doc/html/*

	dodir ${LIB}
	insinto ${LIB}
	cp -r output/* ${D}/${LIB}
	doins output/sbcl.core
	newins output/sbcl.core sbcl-dist.core

	insinto /usr/lib/sbcl
	doins ${FILESDIR}/install-clc.lisp

	exeinto /usr/lib/common-lisp/bin
	cp ${FILESDIR}/sbcl.sh sbcl.sh
	doexe sbcl.sh

	insinto /etc
	doins ${FILESDIR}/sbcl.rc

	dodir /usr/share/common-lisp/source/sbcl
	cp -r src/* ${D}/usr/share/common-lisp/source/sbcl

	dodir /etc/env.d

	echo "SBCL_HOME=${LIB}" > ${D}/etc/env.d/10sbcl

	export INSTALL_ROOT=${D}/usr
	export SBCL_HOME=${D}/usr/lib/sbcl
	export GNUMAKE="make"

	sh install.sh || die
}

pkg_postinst() {
	einfo ">>> Fixing permissions for executables and directories..."
	find /usr/share/common-lisp/source -type d -o \( -type f -perm +111 \) \
		|xargs chmod 755
	einfo ">>> fix permissions for non-executable files..."
	find /usr/share/common-lisp/source -type f ! -perm -111 \
		|xargs chmod 644

	/usr/sbin/register-common-lisp-implementation sbcl
}

pkg_postrm() {
	/usr/sbin/unregister-common-lisp-implementation sbcl
}
