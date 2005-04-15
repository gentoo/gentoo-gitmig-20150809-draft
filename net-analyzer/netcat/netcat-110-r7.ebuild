# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netcat/netcat-110-r7.ebuild,v 1.2 2005/04/15 01:46:07 tgall Exp $

inherit eutils toolchain-funcs flag-o-matic

MY_P=nc${PV}
DESCRIPTION="the network swiss army knife"
HOMEPAGE="http://www.securityfocus.com/tools/137"
SRC_URI="http://www.atstake.com/research/tools/network_utilities/${MY_P}.tgz
	ftp://sith.mimuw.edu.pl/pub/users/baggins/IPv6/nc-v6-20000918.patch.gz
	mirror://gentoo/${PF}-gentoo-deb-patches.tbz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~sparc ~x86 ~ppc64"
IUSE="ipv6 static crypt GAPING_SECURITY_HOLE"

DEPEND="virtual/libc
	crypt? ( dev-libs/libmix )"

src_unpack() {
	mkdir ${S}
	cd ${S}
	unpack ${MY_P}.tgz
	unpack ${PF}-gentoo-deb-patches.tbz2
	epatch ${DISTDIR}/nc-v6-20000918.patch.gz
	EPATCH_SUFFIX="patch" epatch ${S}/patches
	sed -i 's:#define HAVE_BIND:#undef HAVE_BIND:' netcat.c
	sed -i 's:#define FD_SETSIZE 16:#define FD_SETSIZE 1024:' netcat.c #34250
}

src_compile() {
	export XLIBS=""
	export XFLAGS="-DLINUX -DTELNET"
	use ipv6 && XFLAGS="${XFLAGS} -DINET6"
	use static && export STATIC="-static"
	use crypt && XFLAGS="${XFLAGS} -DAESCRYPT" && XLIBS="${XLIBS} -lmix"
	use GAPING_SECURITY_HOLE && XFLAGS="${XFLAGS} -DGAPING_SECURITY_HOLE"
	CC="$(tc-getCC) ${CFLAGS}" make -e nc || die
}

src_install() {
	dobin nc || die "dobin failed"
	dodoc README* netcat.blurb
	doman nc.1
	docinto scripts
	dodoc scripts/*
}
