# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdesktop/rdesktop-1.1.0-r1.ebuild,v 1.11 2003/08/03 04:01:58 vapier Exp $

DESCRIPTION="A Remote Desktop Protocol Client"
HOMEPAGE="http://rdesktop.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE="ssl debug"

DEPEND="virtual/x11
	ssl? ( >=dev-libs/openssl-0.9.6b )"

src_compile() {
	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		`use_with ssl openssl` \
		`use_with debug` \
		|| die

	use ssl && echo "CFLAGS += -I/usr/include/openssl" >> Makeconf

	# Hold on tight folks, this ain't purdy
	if [ ! -z "${CXXFLAGS}" ]; then
		sed -e 's:-O2::g' Makefile > Makefile.tmp
		mv Makefile.tmp Makefile
		echo "CFLAGS += ${CXXFLAGS}" >> Makeconf
	fi

	emake || die "compile problem"
}

src_install() {
	dobin rdesktop
	doman rdesktop.1
	dodoc COPYING
}
