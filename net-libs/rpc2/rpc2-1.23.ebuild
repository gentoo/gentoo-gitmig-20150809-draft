# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/rpc2/rpc2-1.23.ebuild,v 1.3 2005/02/05 14:34:53 griffon26 Exp $

DESCRIPTION="Remote procedure call package for IP/UDP (used by Coda)"
HOMEPAGE="http://www.coda.cs.cmu.edu/"
SRC_URI="ftp://ftp.coda.cs.cmu.edu/pub/rpc2/src/${P}.tar.gz"
IUSE=""
SLOT="1"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa ~mips ~amd64 ~ia64"

RDEPEND="virtual/libc
	>=sys-libs/lwp-1.12"

DEPEND="${RDEPEND}
	sys-apps/gawk
	sys-apps/sed
	sys-apps/grep
	sys-devel/libtool"

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dodoc NEWS
}
