# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/expat/expat-1.95.7.ebuild,v 1.6 2004/03/21 11:23:42 kumba Exp $

inherit gnuconfig

DESCRIPTION="XML parsing libraries"
HOMEPAGE="http://expat.sourceforge.net/"
SRC_URI="mirror://sourceforge/expat/${P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~amd64 ~x86 ~ppc ~sparc ~mips ~alpha ~hppa ~ia64 ppc64 s390"

DEPEND="virtual/glibc"

src_compile() {
	# Detect mips systems properly
	use mips && gnuconfig_update
}

src_install() {
	einstall mandir=${D}/usr/share/man/man1 || die
	dodoc Changes README                    || die "dodoc failed"
	dohtml doc/*                            || die "dohtml failed"
}
