# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netcat/netcat-110-r3.ebuild,v 1.4 2003/08/18 20:36:28 mholzer Exp $

MY_P=nc${PV}
S=${WORKDIR}/nc-${PV}
DESCRIPTION="A network piping program"
SRC_URI="http://www.atstake.com/research/tools/${MY_P}.tgz
ipv6?( ftp://sith.mimuw.edu.pl/pub/users/baggins/IPv6/nc-v6-20000918.patch.gz )"
HOMEPAGE="http://www.atstake.com/research/tools/network_utilities/"

IUSE="ipv6 static"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~ppc ~sparc ~alpha hppa"

DEPEND="virtual/glibc"

src_unpack() {
	mkdir ${S}
	cd ${S}
	unpack ${MY_P}.tgz
	if [ -n "`use ipv6`" ]; then
		unpack nc-v6-20000918.patch.gz
		patch -p1 < nc-v6-20000918.patch
	fi
}

src_compile() {

	cp netcat.c netcat.c.orig
	sed -e "s:#define HAVE_BIND:#undef HAVE_BIND:" \
		netcat.c.orig > netcat.c

	export XFLAGS="-DLINUX"
	[ -n "`use ipv6`" ] && XFLAGS="${XFLAGS} -DINET6"
	[ -n "`use static`" ] && export STATIC="-static"
	CC="gcc ${CFLAGS}" make -e nc || die
}

src_install () {
	dobin nc
	dodoc README
	docinto scripts
	dodoc scripts/*
}
