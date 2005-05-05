# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/rvm/rvm-1.11.ebuild,v 1.1 2005/05/05 13:20:14 griffon26 Exp $

DESCRIPTION="Recoverable Virtual Memory (used by Coda)"
HOMEPAGE="http://www.coda.cs.cmu.edu/"
SRC_URI="ftp://ftp.coda.cs.cmu.edu/pub/rvm/src/${P}.tar.gz"
IUSE=""
SLOT="1"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~amd64 ~ia64"

DEPEND="virtual/libc
	>=sys-libs/lwp-2.0
	sys-apps/grep
	sys-devel/libtool
	sys-devel/gcc"

RDEPEND="virtual/libc
	>=sys-libs/lwp-2.0"


src_install() {
	make DESTDIR=${D} install || die

	dodoc NEWS
}
