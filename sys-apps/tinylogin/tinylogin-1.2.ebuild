# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/tinylogin/tinylogin-1.2.ebuild,v 1.2 2003/02/13 16:18:20 vapier Exp $

DESCRIPTION="worlds smallest login/passwd/getty/etc"
HOMEPAGE="http://tinylogin.busybox.net/"
SRC_URI="http://tinylogin.busybox.net/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/glibc"
#RDEPEND=""

src_compile() {
	local myconf
	use static && myconf="${myconf} DOSTATIC=true"
	emake ${myconf} || die
}

src_install() {
	into /
	dobin tinylogin
	into /usr
	dodoc Changelog README TODO

	cd docs
	doman *.1 *.8
	dodoc *.txt
	dohtml -r tinylogin.busybox.net
	docinto pod
	dodoc *.pod
}
