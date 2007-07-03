# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmemcache/libmemcache-1.4.0_rc2.ebuild,v 1.1 2007/07/03 07:32:03 robbat2 Exp $

inherit toolchain-funcs autotools

MY_PV="${PV/_rc/.rc}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="C API for memcached"
HOMEPAGE="http://people.freebsd.org/~seanc/libmemcache/"
SRC_URI="http://people.freebsd.org/~seanc/libmemcache/${MY_P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~sparc-fbsd ~x86"
IUSE=""

RDEPEND="net-misc/memcached"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	rm -rf ${S}/test/unit
	sed -i -e '/DIR/s,unit,,g' ${S}/test/Makefile.am
	sed -i -e 's,test/unit/Makefile,,g' ${S}/configure.ac
	cd ${S}
	eautoreconf
}

src_compile() {
	econf
	emake
	emake docs
}

src_install() {
	emake install DESTDIR="${D}"
	dodoc ChangeLog
}
