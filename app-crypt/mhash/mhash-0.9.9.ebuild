# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/mhash/mhash-0.9.9.ebuild,v 1.10 2011/02/06 05:28:23 leio Exp $

inherit eutils

DESCRIPTION="library providing a uniform interface to a large number of hash algorithms"
HOMEPAGE="http://mhash.sourceforge.net/"
SRC_URI="mirror://sourceforge/mhash/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh ~sparc x86 ~sparc-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	econf \
		--enable-static \
		--enable-shared || die
	emake || die "make failure"
	cd doc && emake mhash.html || die "failed to build html"
}

src_install() {
	dodir /usr/{bin,include,lib}
	make install DESTDIR="${D}" || die "install failure"

	dodoc AUTHORS INSTALL NEWS README TODO THANKS ChangeLog
	dodoc doc/*.txt doc/skid* doc/*.c
	dohtml doc/mhash.html || die "dohtml failed"
}
