# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdate/rdate-1.4-r3.ebuild,v 1.9 2008/06/01 21:21:11 robbat2 Exp $

inherit flag-o-matic

DESCRIPTION="use TCP or UDP to retrieve the current time of another machine"
HOMEPAGE="http://www.apps.ietf.org/rfc/rfc868.html"
SRC_URI="ftp://people.redhat.com/sopwith/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86"
IUSE="ipv6"

DEPEND="virtual/libc"

src_compile() {
	use ipv6 && append-flags "-DINET6"
	emake RCFLAGS="${CFLAGS}" || die "emake failed"
}

src_install(){
	make prefix="${D}/usr" install || die "make install failed"
	newinitd ${FILESDIR}/rdate-initd-1.4-r3 rdate
	newconfd ${FILESDIR}/rdate-confd rdate
}
