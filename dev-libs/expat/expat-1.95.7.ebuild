# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/expat/expat-1.95.7.ebuild,v 1.4 2004/03/02 16:38:49 iggy Exp $

DESCRIPTION="XML parsing libraries"
HOMEPAGE="http://expat.sourceforge.net/"
SRC_URI="mirror://sourceforge/expat/${P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~amd64 ~x86 ~ppc ~sparc ~alpha ~hppa ~ia64 ppc64 s390"

DEPEND="virtual/glibc"

src_install() {
	einstall mandir=${D}/usr/share/man/man1 || die
	dodoc Changes README                    || die "dodoc failed"
	dohtml doc/*                            || die "dohtml failed"
}
