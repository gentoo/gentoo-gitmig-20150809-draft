# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdesktop/rdesktop-1.1.0-r1.ebuild,v 1.10 2003/02/10 10:32:00 seemant Exp $

IUSE="ssl"

S=${WORKDIR}/${P}
DESCRIPTION="A Remote Desktop Protocol Client"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://rdesktop.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"

DEPEND="virtual/x11
	ssl? ( >=dev-libs/openssl-0.9.6b )"

src_compile() {
	local myconf
	use ssl && myconf="--with-openssl"
	use ssl || myconf="--without-openssl"

	[ "${DEBUG}" ] && myconf="${myconf} --with-debug"

	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		${myconf} || die

	use ssl && echo "CFLAGS += -I/usr/include/openssl" >> Makeconf

	# Hold on tight folks, this ain't purdy
	if [ ! -z "${CXXFLAGS}" ]; then
		sed -e 's:-O2::g' Makefile > Makefile.tmp
		mv Makefile.tmp Makefile
		echo "CFLAGS += ${CXXFLAGS}" >> Makeconf
	fi

	emake || die "compile problem"
}

src_install () {
	dobin rdesktop
	doman rdesktop.1
	dodoc COPYING
}
