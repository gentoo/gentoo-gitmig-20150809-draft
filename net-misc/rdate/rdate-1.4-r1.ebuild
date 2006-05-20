# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdate/rdate-1.4-r1.ebuild,v 1.2 2006/05/20 06:49:59 robbat2 Exp $

inherit flag-o-matic

DESCRIPTION="use TCP or UDP to retrieve the current time of another machine"
HOMEPAGE="http://www.freshmeat.net/projects/rdate/"
SRC_URI="ftp://people.redhat.com/sopwith/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~ia64 ~amd64 ~mips ~ppc64"
IUSE="ipv6"

DEPEND="virtual/libc"

src_compile() {
	use ipv6 && append-flags "-DINET6"
	emake RCFLAGS="${CFLAGS}" || die "emake failed"
}

src_install(){
	make prefix="${D}/usr" install || die "make install failed"
	newinitd ${FILESDIR}/rdate-initd rdate
	newconfd ${FILESDIR}/rdate-confd rdate
}
