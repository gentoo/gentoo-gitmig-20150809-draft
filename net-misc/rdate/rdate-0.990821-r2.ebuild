# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdate/rdate-0.990821-r2.ebuild,v 1.1 2004/09/07 05:23:21 robbat2 Exp $

inherit flag-o-matic

DESCRIPTION="use TCP or UDP to retrieve the current time of another machine"
HOMEPAGE="http://www.freshmeat.net/projects/rdate/"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/network/misc/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~ppc sparc alpha hppa ia64 amd64 ~mips ppc64"
IUSE="ipv6"

DEPEND=">=sys-apps/sed-4"

src_compile() {
	use ipv6 && append-flags "-DINET6"
	emake CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install(){
	dodir /usr/{bin,share/man/man1} || die "dodir failed"
	make DESTDIR=${D} install       || die "Failed to install rdate"
	dodoc README.linux              || die "dodoc failed"
}
