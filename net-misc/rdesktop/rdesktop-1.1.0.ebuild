# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Jo Ryden <jo@our-own.net>
# Maintainer: Donny Davies <woodchip@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdesktop/rdesktop-1.1.0.ebuild,v 1.1 2002/02/09 01:23:01 woodchip Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A Remote Desktop Protocol Client"
SRC_URI="http://prdownloads.sourceforge.net/${PN}/${P}.tar.gz"
HOMEPAGE="http://rdesktop.sourceforge.net/"

DEPEND="x11-base/xfree ssl? ( >=dev-libs/openssl-0.9.6b )"

src_compile() {
	local myconf
	use ssl && myconf="--with-openssl"
	use ssl || myconf="--without-openssl"
	[ "${DEBUG}" ] && myconf="${myconf} --with-debug"
	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man $myconf || die
	use ssl && echo "CFLAGS += -I/usr/include/openssl" >> Makeconf
	# Hold on tight folks, this ain't purdy
	if [ ! -z "${CXXFLAGS}" ]; then
		sed -e 's/-O2//g' Makefile > Makefile.tmp && mv Makefile.tmp Makefile
		echo "CFLAGS += ${CXXFLAGS}" >> Makeconf
	fi
	emake || die "compile problem"
}

src_install () {
	dobin rdesktop
	doman rdesktop.1
	dodoc COPYING
}
