# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/mhash/mhash-0.9.1.ebuild,v 1.6 2004/09/21 23:25:05 kito Exp $

DESCRIPTION="library providing a uniform interface to a large number of hash algorithms"
HOMEPAGE="http://mhash.sourceforge.net/"
SRC_URI="mirror://sourceforge/mhash/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha arm hppa amd64 ia64 s390 ~ppc-macos"
IUSE=""

DEPEND="virtual/libc"
RDEPEND=""

src_compile() {
	local myconf
	myconf="--enable-static --enable-shared"
	econf ${myconf} || die
	emake || die "make failure"
}

src_install() {
	dodir /usr/{bin,include,lib}
	einstall || die "install failure"

	dodoc AUTHORS INSTALL NEWS README TODO THANKS ChangeLog
	dodoc doc/*.txt doc/skid*
	prepalldocs
	cd doc && dohtml mhash.html || die "dohtml failed"
}
