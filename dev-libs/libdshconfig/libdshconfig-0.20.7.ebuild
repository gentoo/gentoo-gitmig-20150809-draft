# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libdshconfig/libdshconfig-0.20.7.ebuild,v 1.3 2003/02/13 10:41:23 vapier Exp $

DESCRIPTION="Library for parsing dsh.style configuration files"
SRC_URI="http://www.netfort.gr.jp/~dancer/software/downloads/${P}.tar.gz"
HOMEPAGE="http://www.netfort.gr.jp/~dancer/software/downloads/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc"
RDEPEND="net-misc/openssh"

src_compile() {
	local myconf="--with-gnu-ld"
	use pic \
		&& myconf="${myconf} --with-pic" \
		|| myconf="${myconf} --without-pic"
	econf ${myconf}

	make || die
}

src_install() {
	make install DESTDIR=${D} || die
}
