# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/mhash/mhash-0.9.2.ebuild,v 1.1 2005/02/14 12:46:13 robbat2 Exp $

inherit libtool

DESCRIPTION="library providing a uniform interface to a large number of hash algorithms"
HOMEPAGE="http://mhash.sourceforge.net/"
SRC_URI="mirror://sourceforge/mhash/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha arm amd64 hppa ia64 ppc ~ppc-macos s390 sparc x86 ppc64 ~mips"
IUSE=""

DEPEND="virtual/libc"
RDEPEND=""

src_unpack() {
	unpack ${A}
	uclibctoolize
}

src_compile() {
	local myconf
	myconf="--enable-static --enable-shared"
	econf ${myconf} || die
	emake || die "make failure"
}

src_install() {
	dodir /usr/{bin,include,lib}
	emake install DESTDIR="${D}" || die "install failure"

	dodoc AUTHORS INSTALL NEWS README TODO THANKS ChangeLog
	dodoc doc/*.txt doc/skid*
	prepalldocs
	cd doc && dohtml mhash.html || die "dohtml failed"
}
