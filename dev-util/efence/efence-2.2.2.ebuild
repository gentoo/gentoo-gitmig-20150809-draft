# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/efence/efence-2.2.2.ebuild,v 1.16 2005/01/05 10:30:03 ka0ttic Exp $

inherit gcc

MY_P="ElectricFence-${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="old crusty malloc() debugger for Linux and Unix"
HOMEPAGE="http://perens.com/FreeSoftware/"
SRC_URI="ftp://ftp.perens.com/pub/ElectricFence/Beta/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	if ! emake CC="$(gcc-getCC)" ; then
		if [ "`gcc-major-version`" == "3" ] ; then
			eerror "gcc-3.x and efence is NOT SUPPORTED on Gentoo."
			eerror "You should:"
			eerror "   (1) use valgrind"
			eerror "   (2) fix efence to work with gcc-3.x and send the fixes to us"
			eerror ""
			eerror "Do NOT file a bug about this package unless"
			eerror "you have a patch to fix the problems."
			die "efence sucks with gcc-3.x"
		else
			die "Could not compile"
		fi
	fi
}

src_install() {
	dodir /usr/bin /usr/lib /usr/share/man/man3
	make \
		BIN_INSTALL_DIR="${D}/usr/bin" \
		LIB_INSTALL_DIR="${D}/usr/lib" \
		MAN_INSTALL_DIR="${D}/usr/share/man/man3" \
		install \
		|| die "make install failed"
	dodoc CHANGES README
}
