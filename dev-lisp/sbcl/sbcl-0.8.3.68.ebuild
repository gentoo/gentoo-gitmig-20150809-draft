# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/sbcl/sbcl-0.8.3.68.ebuild,v 1.1 2003/10/04 08:15:12 mkennedy Exp $

DESCRIPTION="Steel Bank Common Lisp"
HOMEPAGE="http://sbcl.sourceforge.net/"
BV_X86=0.8.1
BV_PPC=0.7.13
DEB_PV=1
SRC_URI="http://ftp.debian.org/debian/pool/main/s/sbcl/sbcl_${PV}.orig.tar.gz
	http://ftp.debian.org/debian/pool/main/s/sbcl/sbcl_${PV}-${DEB_PV}.diff.gz
	x86? ( mirror://sourceforge/sbcl/${PN}-${BV_X86}-x86-linux-binary.tar.bz2 )
	ppc? ( mirror://sourceforge/sbcl/${PN}-${BV_PPC}-binary-linux-ppc.tar.bz2 )"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~ppc -sparc "
PROVIDE="virtual/commonlisp"
# the SRC_URI trickery needs this
DEPEND=">=sys-apps/portage-2.0.27
	dev-lisp/common-lisp-controller"

S=${WORKDIR}/${P}

src_unpack() {
	if use x86; then
		unpack ${PN}-${BV_X86}-x86-linux-binary.tar.bz2
		mv ${PN}-${BV_X86} x86-binary
	elif use ppc; then
		unpack ${PN}-${BV_PPC}-ppc-linux-binary.tar.bz2
		mv ${PN}-${BV_PPC}-ppc-linux ppc-binary
	fi
	unpack sbcl_${PV}.orig.tar.gz
	unpack sbcl_${PV}-${DEB_PV}.diff.gz
	epatch sbcl_${PV}-${DEB_PV}.diff
	cd ${S}/src/code && epatch ${FILESDIR}/gc.lisp-linux-2.6.patch
}

src_compile() {
	local bindir
	use x86 && bindir=../x86-binary
	use ppc && bindir=../ppc-binary
	PATH=${bindir}/src/runtime:${PATH} SBCL_HOME=${bindir}/output GNUMAKE=make \
		./make.sh 'sbcl --sysinit /dev/null --userinit /dev/null --noprogrammer --core ${bindir}/output/sbcl.core'
}

src_install() {
	insinto /etc/
	doins ${FILESDIR}/sbcl.rc

	exeinto /usr/lib/common-lisp/bin
	cp ${FILESDIR}/sbcl.sh sbcl.sh
	doexe sbcl.sh

	INSTALL_ROOT=${D}/usr sh install.sh
	mv ${D}/usr/lib/sbcl/sbcl.core ${D}/usr/lib/sbcl/sbcl-dist.core

	insinto /usr/lib/sbcl
	doins ${FILESDIR}/install-clc.lisp

	dodir /usr/share
	mv ${D}/usr/man ${D}/usr/share/
	doman debian/sbcl-asdf-install.1

	dohtml doc/html/*
	dodoc BUGS CREDITS NEWS README INSTALL COPYING \
		debian/README.Debian debian/changelog debian/copyright

	find ${D} -type f -name .cvsignore |xargs rm -f
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

pkg_prerm() {
	/usr/sbin/unregister-common-lisp-implementation sbcl
}