# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmemcached/libmemcached-0.11.ebuild,v 1.1 2007/11/28 19:27:10 robbat2 Exp $

inherit toolchain-funcs autotools

DESCRIPTION="libmemcached is a C client library to the memcached server"
HOMEPAGE="http://tangent.org/552/libmemcached.html"
SRC_URI="http://download.tangent.org/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~sparc-fbsd ~x86"
IUSE=""

DEPEND="dev-lang/perl" # for pod2man to generate manpages
RDEPEND=""

#src_compile() {
#	econf
#	emake
#}

src_install() {
	emake install DESTDIR="${D}"
	dodoc ChangeLog AUTHORS NEWS README THANKS TODO
}

# The testcases packaged with libmemcached start up 10 copies of the memcached
# daemon, on 10 different ports, and do not clean up after themselves at all.
# If you want to run them, use ebuild ... compile, and then run 'make test'
# manually as a non-root user.
#src_test() {
#	emake test
#}
src_test() {
	einfo "The testcases are not normally run, as they affect the system"
}
