# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdate/rdate-1.4.ebuild,v 1.3 2004/07/01 21:49:34 squinky86 Exp $

inherit flag-o-matic

DESCRIPTION="use TCP or UDP to retrieve the current time of another machine"
HOMEPAGE="http://www.freshmeat.net/projects/rdate/"
SRC_URI="ftp://people.redhat.com/sopwith/rdate-1.4.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~ia64 ~amd64 ~mips"
IUSE="ipv6"

DEPEND="virtual/libc"

src_compile() {
	use ipv6 && append-flags "-DINET6"
	emake RCFLAGS="${CFLAGS}" || die "emake failed"
}

src_install(){
	make prefix="${D}/usr" install || die "make install failed"
}
