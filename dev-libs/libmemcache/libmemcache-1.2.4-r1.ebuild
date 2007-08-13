# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmemcache/libmemcache-1.2.4-r1.ebuild,v 1.7 2007/08/13 20:26:52 dertobi123 Exp $

inherit toolchain-funcs

DESCRIPTION="C API for memcached"
HOMEPAGE="http://people.freebsd.org/~seanc/libmemcache/"
SRC_URI="http://people.freebsd.org/~seanc/libmemcache/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha ~amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc ~sparc-fbsd x86"
IUSE=""

RDEPEND="net-misc/memcached"

doit() {
	echo "$@"
	$@
}

src_compile() {
	doit $(tc-getCC) ${CFLAGS} -fPIC -c memcache.c || die
	doit $(tc-getCC) ${LDFLAGS} -Wl,-soname -Wl,libmemcache.so.${PV%%.*} -shared -o libmemcache.so.${PV%.*} \
		memcache.o || die
}

src_install() {
	insinto /usr/include
	doins memcache.h || die

	dolib.so libmemcache.so.${PV%.*} || die

	dosym /usr/lib/libmemcache.so.${PV%.*} /usr/lib/libmemcache.so

	doman memcache.4
	dodoc ChangeLog COPYING INSTALL
}
