# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libevent/libevent-1.0c.ebuild,v 1.1 2005/04/04 17:00:38 ka0ttic Exp $

DESCRIPTION="A library to execute a function when a specific event occurs on a file descriptor"
HOMEPAGE="http://monkey.org/~provos/libevent/"
SRC_URI="http://monkey.org/~provos/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~arm ~hppa ~amd64 ~ppc64 ~s390 ~alpha ~ia64"
IUSE=""

RDEPEND=""
DEPEND="sys-devel/autoconf
	>=sys-devel/automake-1.4"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README
}
