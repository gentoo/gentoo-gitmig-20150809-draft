# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdate/rdate-990821-r1.ebuild,v 1.10 2003/10/28 07:14:32 mr_bones_ Exp $

inherit flag-o-matic

DESCRIPTION="use TCP or UDP to retrieve the current time of another machine"
HOMEPAGE="http://www.freshmeat.net/projects/rdate/"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/network/misc/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha hppa ia64"
SLOT="0"

DEPEND=">=sys-apps/sed-4"

IUSE="ipv6"

src_install(){
	use ipv6 && append-flags "-DINET6"

	sed -i "s/^\(CFLAGS = \).*/\1${CFLAGS}/" Makefile || \
		die "sed Makefile failed"

	dodir /usr/{bin,share/man/man1} || die "dodir failed"
	make DESTDIR=${D} install       || die "Failed to install rdate"
	dodoc README.linux              || die "dodoc failed"
}
