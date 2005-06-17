# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libevent/libevent-1.0e.ebuild,v 1.5 2005/06/17 21:18:28 hansmi Exp $

DESCRIPTION="A library to execute a function when a specific event occurs on a file descriptor"
HOMEPAGE="http://monkey.org/~provos/libevent/"
SRC_URI="http://monkey.org/~provos/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ppc ~ppc64 ~s390 sparc x86"
IUSE=""

RDEPEND=""
DEPEND="sys-devel/autoconf
	>=sys-devel/automake-1.4"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README
}
