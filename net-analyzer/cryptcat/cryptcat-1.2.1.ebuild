# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/cryptcat/cryptcat-1.2.1.ebuild,v 1.5 2012/04/06 19:41:24 ago Exp $

inherit eutils toolchain-funcs

DESCRIPTION="netcat clone extended with twofish encryption"
HOMEPAGE="http://farm9.org/Cryptcat/"
SRC_URI="mirror://sourceforge/cryptcat/${PN}-unix-${PV}.tar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND=""

S=${WORKDIR}/unix

src_unpack() {
	unpack ${A}
	cp -a "${S}" "${S}".orig
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
	echo "#define arm arm_timer" >> generic.h
	sed -i \
		-e 's:#define HAVE_BIND:#undef HAVE_BIND:' \
		-e '/^#define FD_SETSIZE 16/s:16:1024:' \
		-e 's:\<LINUX\>:__linux__:' \
		netcat.c generic.h
}

src_install() {
	dobin cryptcat || die "dobin failed"
	dodoc Changelog README README.cryptcat netcat.blurb
}
