# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/tinylogin/tinylogin-1.4.ebuild,v 1.11 2005/02/07 00:55:57 vapier Exp $

DESCRIPTION="worlds smallest login/passwd/getty/etc"
HOMEPAGE="http://tinylogin.busybox.net/"
SRC_URI="http://tinylogin.busybox.net/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE="static make-tinylogin-symlinks"

DEPEND="virtual/libc"

src_compile() {
	local myconf=""
	use static && myconf="${myconf} DOSTATIC=true"
	type -p ${CHOST}-ar && export CROSS=${CHOST}-
	emake ${myconf} || die
}

src_install() {
	make PREFIX="${D}" install || die
	if ! use make-tinylogin-symlinks ; then
		rm -r "${D}"/sbin "${D}"/usr/bin "${D}"/bin/{add*,del*,login,su}
	fi

	doman docs/*.{1,8}

	dodoc Changelog README TODO
	cd docs
	dodoc *.txt
	dohtml -r tinylogin.busybox.net
	docinto pod
	dodoc *.pod
}
