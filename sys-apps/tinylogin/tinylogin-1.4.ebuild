# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/tinylogin/tinylogin-1.4.ebuild,v 1.6 2004/07/15 02:44:01 agriffis Exp $

DESCRIPTION="worlds smallest login/passwd/getty/etc"
HOMEPAGE="http://tinylogin.busybox.net/"
SRC_URI="http://tinylogin.busybox.net/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 arm amd64"
IUSE="static uclibc"

DEPEND="virtual/libc"

src_compile() {
	local myconf=""
	use static && myconf="${myconf} DOSTATIC=true"
	if use uclibc ; then
		myconf="${myconf} \
			CC=/usr/i386-linux-uclibc/bin/i386-uclibc-gcc \
			USE_SYSTEM_PWD=false"
		unset CFLAGS
	fi
	emake ${myconf} || die
}

src_install() {
	into /
	dobin tinylogin || die
	into /usr
	dodoc Changelog README TODO

	cd docs
	doman *.1 *.8
	dodoc *.txt
	dohtml -r tinylogin.busybox.net
	docinto pod
	dodoc *.pod
}
