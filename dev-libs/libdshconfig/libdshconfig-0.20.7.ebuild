# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Library for parsing dsh.style configuration files"
SRC_URI="http://www.netfort.gr.jp/~dancer/software/downloads/libdshconfig-${PV}.tar.gz"
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
