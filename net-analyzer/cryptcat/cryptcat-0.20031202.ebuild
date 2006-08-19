# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/cryptcat/cryptcat-0.20031202.ebuild,v 1.2 2006/08/19 15:22:05 vapier Exp $

inherit eutils toolchain-funcs

DEB_PVER=2
MY_P=${PN}_${PV#0.}
DESCRIPTION="netcat clone extended with twofish encryption"
HOMEPAGE="http://farm9.org/Cryptcat/"
SRC_URI="http://farm9.org/Cryptcat/${MY_P}.tar.gz
	mirror://debian/pool/main/c/cryptcat/${MY_P}-${DEB_PVER}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc sparc x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}"/${MY_P}-2.diff
	echo "#define arm arm_timer" >> generic.h
	sed -i 's:#define HAVE_BIND:#undef HAVE_BIND:' netcat.c
	sed -i 's:#define FD_SETSIZE 16:#define FD_SETSIZE 1024:' netcat.c #34250
	sed -i 's:-DGAPING_SECURITY_HOLE::' Makefile # -e doesn't work at all. See http://www.kb.cert.org/vuls/id/165099
}

src_compile() {
	export XFLAGS="-DLINUX"
	export XLIBS="-lstdc++"
	CC="$(tc-getCC) ${CFLAGS}" make -e cryptcat || die
}

src_install() {
	dobin cryptcat || die
	dodoc Changelog README README.cryptcat
	doman */debian/cryptcat.1
}
